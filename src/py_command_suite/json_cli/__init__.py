"""JSON CLI validation tool package."""

__version__ = "0.1.0"

from .exceptions import (
    JSONCliError,
    JSONParseError,
    JSONValidationError,
    SchemaError,
    FileAccessError,
)
from .validator import (
    load_json_file,
    load_schema_file,
    validate_json_against_schema,
    validate_json_file,
)
from .main import validate_json, cli

__all__ = [
    # Exceptions
    "JSONCliError",
    "JSONParseError",
    "JSONValidationError",
    "SchemaError",
    "FileAccessError",
    # Validator functions
    "load_json_file",
    "load_schema_file",
    "validate_json_against_schema",
    "validate_json_file",
    # CLI commands
    "validate_json",
    "cli",
]
