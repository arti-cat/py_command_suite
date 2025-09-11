"""Tests for JSON validation functionality."""

import json
import pytest
from pathlib import Path
from unittest.mock import patch, mock_open

from py_command_suite.json_cli.validator import (
    load_json_file,
    load_schema_file,
    validate_json_against_schema,
    validate_json_file,
)
from py_command_suite.json_cli.exceptions import (
    JSONParseError,
    JSONValidationError,
    SchemaError,
    FileAccessError,
)


class TestLoadJsonFile:
    """Test JSON file loading functionality."""
    
    def test_load_valid_json(self, tmp_path):
        """Test loading a valid JSON file."""
        json_data = {"name": "test", "value": 42}
        json_file = tmp_path / "test.json"
        json_file.write_text(json.dumps(json_data))
        
        result = load_json_file(json_file)
        assert result == json_data
    
    def test_load_empty_json_object(self, tmp_path):
        """Test loading an empty JSON object."""
        json_file = tmp_path / "empty.json"
        json_file.write_text("{}")
        
        result = load_json_file(json_file)
        assert result == {}
    
    def test_load_json_array(self, tmp_path):
        """Test loading a JSON array."""
        json_data = [1, 2, 3, "test"]
        json_file = tmp_path / "array.json"
        json_file.write_text(json.dumps(json_data))
        
        result = load_json_file(json_file)
        assert result == json_data
    
    def test_file_not_found(self, tmp_path):
        """Test handling of non-existent file."""
        non_existent = tmp_path / "missing.json"
        
        with pytest.raises(FileAccessError) as exc_info:
            load_json_file(non_existent)
        
        assert "File not found" in str(exc_info.value)
        assert exc_info.value.file_path == str(non_existent)
    
    def test_permission_denied(self, tmp_path, monkeypatch):
        """Test handling of permission denied."""
        json_file = tmp_path / "protected.json" 
        json_file.write_text("{}")
        
        # Mock the pathlib.Path.open method instead of builtins.open
        def mock_open_permission_error(*args, **kwargs):
            raise PermissionError("Permission denied")
        
        monkeypatch.setattr(Path, "open", mock_open_permission_error)
        
        with pytest.raises(FileAccessError) as exc_info:
            load_json_file(json_file)
        
        assert "Permission denied" in str(exc_info.value)
    
    def test_invalid_json_syntax(self, tmp_path):
        """Test handling of invalid JSON syntax."""
        json_file = tmp_path / "invalid.json"
        json_file.write_text('{"name": "test", "missing_quote: true}')
        
        with pytest.raises(JSONParseError) as exc_info:
            load_json_file(json_file)
        
        assert "Invalid JSON" in str(exc_info.value)
        assert "line" in str(exc_info.value)
        assert "column" in str(exc_info.value)
    
    def test_empty_file(self, tmp_path):
        """Test handling of empty file."""
        json_file = tmp_path / "empty_file.json"
        json_file.write_text("")
        
        with pytest.raises(JSONParseError) as exc_info:
            load_json_file(json_file)
        
        assert "Invalid JSON" in str(exc_info.value)


class TestLoadSchemaFile:
    """Test JSON schema loading functionality."""
    
    def test_load_valid_schema(self, tmp_path):
        """Test loading a valid JSON schema."""
        schema = {
            "$schema": "http://json-schema.org/draft-07/schema#",
            "type": "object",
            "properties": {
                "name": {"type": "string"},
                "age": {"type": "number"}
            },
            "required": ["name"]
        }
        schema_file = tmp_path / "schema.json"
        schema_file.write_text(json.dumps(schema))
        
        result = load_schema_file(schema_file)
        assert result == schema
    
    def test_load_simple_schema(self, tmp_path):
        """Test loading a simple schema without $schema."""
        schema = {"type": "object"}
        schema_file = tmp_path / "simple.json"
        schema_file.write_text(json.dumps(schema))
        
        result = load_schema_file(schema_file)
        assert result == schema
    
    def test_invalid_schema_syntax(self, tmp_path):
        """Test handling of schema with invalid JSON syntax."""
        schema_file = tmp_path / "bad_schema.json"
        schema_file.write_text('{"type": "object",}')  # Trailing comma
        
        with pytest.raises(SchemaError) as exc_info:
            load_schema_file(schema_file)
        
        assert "Failed to load schema" in str(exc_info.value)
    
    def test_invalid_schema_structure(self, tmp_path):
        """Test handling of invalid schema structure."""
        # Invalid schema with wrong type specification
        invalid_schema = {"type": "invalid_type"}
        schema_file = tmp_path / "invalid_schema.json"
        schema_file.write_text(json.dumps(invalid_schema))
        
        with pytest.raises(SchemaError) as exc_info:
            load_schema_file(schema_file)
        
        assert "Invalid JSON schema" in str(exc_info.value)
    
    def test_schema_file_not_found(self, tmp_path):
        """Test handling of missing schema file."""
        missing_schema = tmp_path / "missing_schema.json"
        
        with pytest.raises(SchemaError) as exc_info:
            load_schema_file(missing_schema)
        
        assert "Failed to load schema" in str(exc_info.value)


class TestValidateJsonAgainstSchema:
    """Test JSON validation against schema."""
    
    def test_valid_data_against_schema(self):
        """Test validating valid data against schema."""
        schema = {
            "type": "object",
            "properties": {
                "name": {"type": "string"},
                "age": {"type": "number"}
            },
            "required": ["name"]
        }
        data = {"name": "John", "age": 30}
        
        # Should not raise an exception
        validate_json_against_schema(data, schema)
    
    def test_invalid_data_missing_required(self):
        """Test validation failure for missing required field."""
        schema = {
            "type": "object", 
            "properties": {
                "name": {"type": "string"},
                "age": {"type": "number"}
            },
            "required": ["name"]
        }
        data = {"age": 30}  # Missing required 'name'
        
        with pytest.raises(JSONValidationError) as exc_info:
            validate_json_against_schema(data, schema, "test.json")
        
        assert "JSON validation failed" in str(exc_info.value)
        assert exc_info.value.file_path == "test.json"
        assert len(exc_info.value.validation_errors) > 0
        assert "'name' is a required property" in str(exc_info.value.validation_errors[0])
    
    def test_invalid_data_wrong_type(self):
        """Test validation failure for wrong data type."""
        schema = {
            "type": "object",
            "properties": {
                "name": {"type": "string"},
                "age": {"type": "number"}
            }
        }
        data = {"name": "John", "age": "thirty"}  # age should be number
        
        with pytest.raises(JSONValidationError) as exc_info:
            validate_json_against_schema(data, schema)
        
        assert "JSON validation failed" in str(exc_info.value)
        assert len(exc_info.value.validation_errors) > 0
    
    def test_nested_validation_error(self):
        """Test validation error with nested path."""
        schema = {
            "type": "object",
            "properties": {
                "person": {
                    "type": "object", 
                    "properties": {
                        "name": {"type": "string"}
                    },
                    "required": ["name"]
                }
            }
        }
        data = {"person": {}}  # Missing required nested name
        
        with pytest.raises(JSONValidationError) as exc_info:
            validate_json_against_schema(data, schema)
        
        errors = exc_info.value.validation_errors
        assert len(errors) > 0
        assert "person" in errors[0]
    
    def test_array_validation(self):
        """Test validation of array data."""
        schema = {
            "type": "array",
            "items": {"type": "string"},
            "minItems": 1
        }
        
        # Valid array
        validate_json_against_schema(["hello", "world"], schema)
        
        # Invalid array (wrong item type)
        with pytest.raises(JSONValidationError):
            validate_json_against_schema(["hello", 123], schema)
        
        # Invalid array (too few items)
        with pytest.raises(JSONValidationError):
            validate_json_against_schema([], schema)


class TestValidateJsonFile:
    """Test complete JSON file validation."""
    
    def test_validate_json_syntax_only(self, tmp_path):
        """Test validation of JSON syntax without schema."""
        json_data = {"test": "data"}
        json_file = tmp_path / "test.json"
        json_file.write_text(json.dumps(json_data))
        
        result = validate_json_file(json_file)
        assert result is True
    
    def test_validate_with_schema_success(self, tmp_path):
        """Test successful validation against schema."""
        # Create JSON file
        json_data = {"name": "John", "age": 30}
        json_file = tmp_path / "person.json"
        json_file.write_text(json.dumps(json_data))
        
        # Create schema file
        schema = {
            "type": "object",
            "properties": {
                "name": {"type": "string"},
                "age": {"type": "number"}
            },
            "required": ["name"]
        }
        schema_file = tmp_path / "person_schema.json"
        schema_file.write_text(json.dumps(schema))
        
        result = validate_json_file(json_file, schema_file)
        assert result is True
    
    def test_validate_with_schema_failure(self, tmp_path):
        """Test validation failure against schema."""
        # Create JSON file with missing required field
        json_data = {"age": 30}
        json_file = tmp_path / "person.json"
        json_file.write_text(json.dumps(json_data))
        
        # Create schema file
        schema = {
            "type": "object",
            "properties": {
                "name": {"type": "string"},
                "age": {"type": "number"}
            },
            "required": ["name"]
        }
        schema_file = tmp_path / "person_schema.json"
        schema_file.write_text(json.dumps(schema))
        
        with pytest.raises(JSONValidationError):
            validate_json_file(json_file, schema_file)
    
    def test_invalid_json_file(self, tmp_path):
        """Test handling of invalid JSON file."""
        json_file = tmp_path / "invalid.json"
        json_file.write_text('{"invalid": json}')
        
        with pytest.raises(JSONParseError):
            validate_json_file(json_file)
    
    def test_invalid_schema_file(self, tmp_path):
        """Test handling of invalid schema file."""
        # Create valid JSON file
        json_file = tmp_path / "data.json"
        json_file.write_text('{"test": "data"}')
        
        # Create invalid schema file
        schema_file = tmp_path / "bad_schema.json" 
        schema_file.write_text('{"type": "invalid_type"}')
        
        with pytest.raises(SchemaError):
            validate_json_file(json_file, schema_file)
    
    def test_missing_files(self, tmp_path):
        """Test handling of missing files."""
        missing_json = tmp_path / "missing.json"
        missing_schema = tmp_path / "missing_schema.json"
        
        # Missing JSON file
        with pytest.raises(FileAccessError):
            validate_json_file(missing_json)
        
        # JSON exists, schema missing
        json_file = tmp_path / "data.json"
        json_file.write_text('{"test": "data"}')
        
        with pytest.raises(SchemaError):
            validate_json_file(json_file, missing_schema)