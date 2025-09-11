"""Custom exceptions for JSON CLI tool."""

from typing import Optional


class JSONCliError(Exception):
    """Base exception for JSON CLI tool errors."""

    def __init__(self, message: str, file_path: Optional[str] = None) -> None:
        """Initialize with error message and optional file path.

        Args:
            message: The error message
            file_path: Optional file path where the error occurred
        """
        self.file_path = file_path
        super().__init__(message)


class JSONParseError(JSONCliError):
    """Raised when JSON parsing fails."""

    pass


class JSONValidationError(JSONCliError):
    """Raised when JSON validation against schema fails."""

    def __init__(
        self,
        message: str,
        file_path: Optional[str] = None,
        validation_errors: Optional[list[str]] = None,
    ) -> None:
        """Initialize with validation details.

        Args:
            message: The error message
            file_path: Optional file path where validation failed
            validation_errors: List of specific validation errors
        """
        self.validation_errors = validation_errors or []
        super().__init__(message, file_path)


class SchemaError(JSONCliError):
    """Raised when schema file has issues."""

    pass


class FileAccessError(JSONCliError):
    """Raised when file cannot be accessed or read."""

    def __init__(self, message: str, file_path: Optional[str] = None, suggestion: Optional[str] = None) -> None:
        """Initialize with access error details.
        
        Args:
            message: The error message
            file_path: Optional file path where error occurred
            suggestion: Optional suggestion for resolution
        """
        self.suggestion = suggestion
        super().__init__(message, file_path)


class FileSizeError(JSONCliError):
    """Raised when file size exceeds limits."""
    
    def __init__(self, message: str, file_path: Optional[str] = None, file_size: Optional[int] = None, limit: Optional[int] = None) -> None:
        """Initialize with file size details.
        
        Args:
            message: The error message
            file_path: Optional file path
            file_size: Actual file size in bytes
            limit: Size limit in bytes
        """
        self.file_size = file_size
        self.limit = limit
        super().__init__(message, file_path)
