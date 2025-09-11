"""JSON validation module using jsonschema."""

import json
from pathlib import Path
from typing import Any, Dict, Optional

import jsonschema
from jsonschema import validate, ValidationError, SchemaError as JsonSchemaError

from .exceptions import (
    JSONParseError,
    JSONValidationError,
    SchemaError,
    FileAccessError,
)


def load_json_file(file_path: Path) -> Dict[str, Any]:
    """Load and parse a JSON file.

    Args:
        file_path: Path to the JSON file

    Returns:
        Parsed JSON data as dictionary

    Raises:
        FileAccessError: If file cannot be read
        JSONParseError: If JSON parsing fails
    """
    try:
        with file_path.open("r", encoding="utf-8") as f:
            return json.load(f)
    except FileNotFoundError:
        raise FileAccessError(f"File not found: {file_path}", str(file_path))
    except PermissionError:
        raise FileAccessError(
            f"Permission denied reading file: {file_path}", str(file_path)
        )
    except json.JSONDecodeError as e:
        raise JSONParseError(
            f"Invalid JSON in file {file_path}: {e.msg} at line {e.lineno}, column {e.colno}",
            str(file_path),
        )
    except Exception as e:
        raise FileAccessError(
            f"Unexpected error reading file {file_path}: {e}", str(file_path)
        )


def load_schema_file(schema_path: Path) -> Dict[str, Any]:
    """Load and validate a JSON schema file.

    Args:
        schema_path: Path to the JSON schema file

    Returns:
        Parsed schema as dictionary

    Raises:
        SchemaError: If schema is invalid or cannot be loaded
    """
    try:
        schema_data = load_json_file(schema_path)
        # Validate that the schema itself is valid
        jsonschema.Draft7Validator.check_schema(schema_data)
        return schema_data
    except (JSONParseError, FileAccessError) as e:
        raise SchemaError(f"Failed to load schema: {e}", str(schema_path))
    except JsonSchemaError as e:
        raise SchemaError(
            f"Invalid JSON schema in {schema_path}: {e.message}", str(schema_path)
        )


def validate_json_against_schema(
    json_data: Dict[str, Any],
    schema: Dict[str, Any],
    json_file_path: Optional[str] = None,
) -> None:
    """Validate JSON data against a schema.

    Args:
        json_data: The JSON data to validate
        schema: The JSON schema to validate against
        json_file_path: Optional path to the JSON file for error reporting

    Raises:
        JSONValidationError: If validation fails
    """
    try:
        validate(instance=json_data, schema=schema)
    except ValidationError as e:
        # Collect all validation errors
        validator = jsonschema.Draft7Validator(schema)
        errors = []
        for error in validator.iter_errors(json_data):
            # Format the error path
            path = (
                " -> ".join(str(p) for p in error.absolute_path)
                if error.absolute_path
                else "root"
            )
            errors.append(f"At '{path}': {error.message}")

        raise JSONValidationError(
            f"JSON validation failed: {e.message}", json_file_path, errors
        )


def validate_json_file(
    json_file_path: Path, schema_file_path: Optional[Path] = None
) -> bool:
    """Validate a JSON file against an optional schema.

    Args:
        json_file_path: Path to the JSON file to validate
        schema_file_path: Optional path to the JSON schema file

    Returns:
        True if validation succeeds

    Raises:
        Various exceptions for different failure modes
    """
    # Load the JSON file
    json_data = load_json_file(json_file_path)

    # If no schema provided, just check if it's valid JSON (already done)
    if schema_file_path is None:
        return True

    # Load and validate the schema
    schema = load_schema_file(schema_file_path)

    # Validate JSON against schema
    validate_json_against_schema(json_data, schema, str(json_file_path))

    return True
