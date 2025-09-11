"""Tests for JSON CLI main module."""

import json
import pytest
from pathlib import Path
from click.testing import CliRunner

from py_command_suite.json_cli.main import validate_json


class TestValidateJsonCLI:
    """Test the main CLI command."""
    
    def test_validate_json_syntax_success(self, tmp_path):
        """Test successful JSON syntax validation via CLI."""
        runner = CliRunner()
        
        # Create valid JSON file
        json_data = {"name": "test", "value": 42}
        json_file = tmp_path / "test.json"
        json_file.write_text(json.dumps(json_data))
        
        result = runner.invoke(validate_json, [str(json_file)])
        
        assert result.exit_code == 0
        assert "valid syntax" in result.output
        assert "✓" in result.output
    
    def test_validate_with_schema_success(self, tmp_path):
        """Test successful validation against schema via CLI."""
        runner = CliRunner()
        
        # Create JSON data
        json_data = {"name": "John", "age": 30}
        json_file = tmp_path / "person.json"
        json_file.write_text(json.dumps(json_data))
        
        # Create schema
        schema = {
            "type": "object",
            "properties": {
                "name": {"type": "string"},
                "age": {"type": "number"}
            },
            "required": ["name"]
        }
        schema_file = tmp_path / "schema.json"
        schema_file.write_text(json.dumps(schema))
        
        result = runner.invoke(validate_json, [
            str(json_file), 
            "--schema", str(schema_file)
        ])
        
        assert result.exit_code == 0
        assert "valid according to schema" in result.output
        assert "✓" in result.output
    
    def test_validate_with_schema_short_option(self, tmp_path):
        """Test validation with short schema option."""
        runner = CliRunner()
        
        json_data = {"name": "Test"}
        json_file = tmp_path / "test.json"
        json_file.write_text(json.dumps(json_data))
        
        schema = {"type": "object", "properties": {"name": {"type": "string"}}}
        schema_file = tmp_path / "schema.json"
        schema_file.write_text(json.dumps(schema))
        
        result = runner.invoke(validate_json, [
            str(json_file), "-s", str(schema_file)
        ])
        
        assert result.exit_code == 0
        assert "valid according to schema" in result.output
    
    def test_invalid_json_syntax(self, tmp_path):
        """Test handling of invalid JSON syntax."""
        runner = CliRunner()
        
        # Create invalid JSON
        json_file = tmp_path / "invalid.json"
        json_file.write_text('{"name": "test", invalid}')
        
        result = runner.invoke(validate_json, [str(json_file)])
        
        assert result.exit_code == 1
        assert "JSON Parse Error" in result.output
        assert "✗" in result.output
    
    def test_validation_failure_basic(self, tmp_path):
        """Test basic validation failure."""
        runner = CliRunner()
        
        # Create JSON missing required field
        json_data = {"age": 30}
        json_file = tmp_path / "person.json"
        json_file.write_text(json.dumps(json_data))
        
        # Create schema requiring name
        schema = {
            "type": "object",
            "properties": {
                "name": {"type": "string"},
                "age": {"type": "number"}
            },
            "required": ["name"]
        }
        schema_file = tmp_path / "schema.json"
        schema_file.write_text(json.dumps(schema))
        
        result = runner.invoke(validate_json, [
            str(json_file), "--schema", str(schema_file)
        ])
        
        assert result.exit_code == 1
        assert "Validation Error" in result.output
        assert "✗" in result.output
    
    def test_validation_failure_verbose(self, tmp_path):
        """Test validation failure with verbose output."""
        runner = CliRunner()
        
        # Create JSON with multiple validation errors
        json_data = {"age": "thirty", "score": "high"}  # Wrong types
        json_file = tmp_path / "data.json"
        json_file.write_text(json.dumps(json_data))
        
        # Create strict schema
        schema = {
            "type": "object",
            "properties": {
                "name": {"type": "string"},
                "age": {"type": "number"},
                "score": {"type": "number"}
            },
            "required": ["name"]
        }
        schema_file = tmp_path / "schema.json"
        schema_file.write_text(json.dumps(schema))
        
        result = runner.invoke(validate_json, [
            str(json_file), "--schema", str(schema_file), "--verbose"
        ])
        
        assert result.exit_code == 1
        assert "Validation Error" in result.output
        assert "Detailed validation errors" in result.output
        assert "1." in result.output  # Numbered error list
    
    def test_schema_error(self, tmp_path):
        """Test handling of schema errors."""
        runner = CliRunner()
        
        # Create valid JSON
        json_file = tmp_path / "data.json"
        json_file.write_text('{"test": "data"}')
        
        # Create invalid schema
        schema_file = tmp_path / "bad_schema.json"
        schema_file.write_text('{"type": "invalid_type"}')
        
        result = runner.invoke(validate_json, [
            str(json_file), "--schema", str(schema_file)
        ])
        
        assert result.exit_code == 1
        assert "Schema Error" in result.output
        assert "✗" in result.output
    
    def test_file_not_found(self, tmp_path):
        """Test handling of missing files."""
        runner = CliRunner()
        
        # Try to validate non-existent file
        missing_file = tmp_path / "missing.json"
        
        result = runner.invoke(validate_json, [str(missing_file)])
        
        assert result.exit_code == 2  # Click's file not found exit code
    
    def test_schema_file_not_found(self, tmp_path):
        """Test handling of missing schema file."""
        runner = CliRunner()
        
        # Create valid JSON
        json_file = tmp_path / "data.json"
        json_file.write_text('{"test": "data"}')
        
        # Reference non-existent schema
        missing_schema = tmp_path / "missing_schema.json"
        
        result = runner.invoke(validate_json, [
            str(json_file), "--schema", str(missing_schema)
        ])
        
        assert result.exit_code == 2  # Click's file not found exit code
    
    def test_version_option(self):
        """Test version option displays version."""
        runner = CliRunner()
        
        result = runner.invoke(validate_json, ["--version"])
        
        assert result.exit_code == 0
        assert "0.1.0" in result.output
    
    def test_help_option(self):
        """Test help option displays usage information."""
        runner = CliRunner()
        
        result = runner.invoke(validate_json, ["--help"])
        
        assert result.exit_code == 0
        assert "Usage:" in result.output
        assert "Validate JSON files" in result.output
        assert "--schema" in result.output
        assert "--verbose" in result.output
        assert "Examples:" in result.output
    
    def test_unexpected_error_verbose(self, tmp_path, monkeypatch):
        """Test handling of unexpected errors with verbose output."""
        runner = CliRunner()
        
        # Create a JSON file
        json_file = tmp_path / "test.json"
        json_file.write_text('{"test": "data"}')
        
        # Mock an unexpected error in validation
        def mock_validate_error(*args, **kwargs):
            raise RuntimeError("Unexpected system error")
        
        monkeypatch.setattr(
            "py_command_suite.json_cli.main.validate_json_file",
            mock_validate_error
        )
        
        result = runner.invoke(validate_json, [str(json_file), "--verbose"])
        
        assert result.exit_code == 1
        assert "Unexpected Error" in result.output
        assert "Traceback:" in result.output
    
    def test_unexpected_error_non_verbose(self, tmp_path, monkeypatch):
        """Test handling of unexpected errors without verbose output."""
        runner = CliRunner()
        
        # Create a JSON file
        json_file = tmp_path / "test.json"
        json_file.write_text('{"test": "data"}')
        
        # Mock an unexpected error
        def mock_validate_error(*args, **kwargs):
            raise RuntimeError("Unexpected system error")
        
        monkeypatch.setattr(
            "py_command_suite.json_cli.main.validate_json_file", 
            mock_validate_error
        )
        
        result = runner.invoke(validate_json, [str(json_file)])
        
        assert result.exit_code == 1
        assert "Unexpected Error" in result.output
        assert "Traceback:" not in result.output


class TestCLIIntegration:
    """Integration tests for the complete CLI workflow."""
    
    def test_complex_json_validation(self, tmp_path):
        """Test validation of complex nested JSON structure."""
        runner = CliRunner()
        
        # Create complex JSON
        complex_data = {
            "users": [
                {"id": 1, "name": "John", "email": "john@example.com"},
                {"id": 2, "name": "Jane", "email": "jane@example.com"}
            ],
            "metadata": {
                "total": 2,
                "created": "2023-01-01T00:00:00Z"
            }
        }
        json_file = tmp_path / "complex.json"
        json_file.write_text(json.dumps(complex_data, indent=2))
        
        # Create matching schema
        schema = {
            "type": "object",
            "properties": {
                "users": {
                    "type": "array",
                    "items": {
                        "type": "object",
                        "properties": {
                            "id": {"type": "number"},
                            "name": {"type": "string"},
                            "email": {"type": "string", "format": "email"}
                        },
                        "required": ["id", "name", "email"]
                    }
                },
                "metadata": {
                    "type": "object",
                    "properties": {
                        "total": {"type": "number"},
                        "created": {"type": "string"}
                    },
                    "required": ["total"]
                }
            },
            "required": ["users", "metadata"]
        }
        schema_file = tmp_path / "complex_schema.json"
        schema_file.write_text(json.dumps(schema, indent=2))
        
        result = runner.invoke(validate_json, [
            str(json_file), "--schema", str(schema_file)
        ])
        
        assert result.exit_code == 0
        assert "valid according to schema" in result.output
    
    def test_large_json_file(self, tmp_path):
        """Test handling of larger JSON files."""
        runner = CliRunner()
        
        # Create a larger JSON structure
        large_data = {
            "items": [{"id": i, "value": f"item_{i}"} for i in range(1000)]
        }
        json_file = tmp_path / "large.json"
        json_file.write_text(json.dumps(large_data))
        
        result = runner.invoke(validate_json, [str(json_file)])
        
        assert result.exit_code == 0
        assert "valid syntax" in result.output