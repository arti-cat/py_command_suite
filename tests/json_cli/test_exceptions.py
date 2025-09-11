"""Tests for JSON CLI exceptions."""

import pytest
from py_command_suite.json_cli.exceptions import (
    JSONCliError,
    JSONParseError,
    JSONValidationError,
    SchemaError,
    FileAccessError,
)


class TestJSONCliError:
    """Test base JSON CLI error class."""
    
    def test_basic_creation(self):
        """Test basic error creation."""
        error = JSONCliError("Test error")
        assert str(error) == "Test error"
        assert error.file_path is None
    
    def test_creation_with_file_path(self):
        """Test error creation with file path."""
        error = JSONCliError("Test error", "test.json")
        assert str(error) == "Test error"
        assert error.file_path == "test.json"


class TestJSONParseError:
    """Test JSON parse error class."""
    
    def test_inherits_from_base(self):
        """Test that JSONParseError inherits from JSONCliError."""
        error = JSONParseError("Parse error")
        assert isinstance(error, JSONCliError)
    
    def test_creation_with_details(self):
        """Test error creation with parse details."""
        error = JSONParseError("Invalid JSON", "data.json")
        assert str(error) == "Invalid JSON"
        assert error.file_path == "data.json"


class TestJSONValidationError:
    """Test JSON validation error class."""
    
    def test_inherits_from_base(self):
        """Test that JSONValidationError inherits from JSONCliError."""
        error = JSONValidationError("Validation failed")
        assert isinstance(error, JSONCliError)
    
    def test_creation_basic(self):
        """Test basic validation error creation."""
        error = JSONValidationError("Validation failed")
        assert str(error) == "Validation failed"
        assert error.validation_errors == []
    
    def test_creation_with_validation_errors(self):
        """Test validation error with specific errors."""
        validation_errors = ["Missing required field", "Invalid type"]
        error = JSONValidationError(
            "Validation failed", 
            "data.json", 
            validation_errors
        )
        assert str(error) == "Validation failed"
        assert error.file_path == "data.json"
        assert error.validation_errors == validation_errors
    
    def test_creation_with_none_errors(self):
        """Test validation error with None errors list."""
        error = JSONValidationError("Validation failed", validation_errors=None)
        assert error.validation_errors == []


class TestSchemaError:
    """Test schema error class."""
    
    def test_inherits_from_base(self):
        """Test that SchemaError inherits from JSONCliError."""
        error = SchemaError("Schema error")
        assert isinstance(error, JSONCliError)
    
    def test_creation_with_schema_path(self):
        """Test schema error with file path."""
        error = SchemaError("Invalid schema", "schema.json")
        assert str(error) == "Invalid schema"
        assert error.file_path == "schema.json"


class TestFileAccessError:
    """Test file access error class."""
    
    def test_inherits_from_base(self):
        """Test that FileAccessError inherits from JSONCliError."""
        error = FileAccessError("File not found")
        assert isinstance(error, JSONCliError)
    
    def test_creation_with_file_path(self):
        """Test file access error with file path."""
        error = FileAccessError("Permission denied", "protected.json")
        assert str(error) == "Permission denied"
        assert error.file_path == "protected.json"