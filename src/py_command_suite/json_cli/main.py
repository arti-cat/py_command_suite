"""Main CLI module for JSON validation tool."""

import sys
from pathlib import Path
from typing import Optional

import click

from .exceptions import (
    JSONCliError,
    JSONParseError,
    JSONValidationError,
    SchemaError,
    FileAccessError,
)
from .validator import validate_json_file


@click.command()
@click.argument(
    "json_file", type=click.Path(exists=True, path_type=Path), metavar="JSON_FILE"
)
@click.option(
    "--schema",
    "-s",
    type=click.Path(exists=True, path_type=Path),
    help="JSON schema file to validate against",
)
@click.option("--verbose", "-v", is_flag=True, help="Show detailed validation errors")
@click.version_option(version="0.1.0", prog_name="json-validate")
def validate_json(
    json_file: Path, schema: Optional[Path] = None, verbose: bool = False
) -> None:
    """Validate JSON files against optional schemas.

    This tool validates JSON files for syntax correctness and optionally
    validates them against a JSON schema for structure and content validation.

    Examples:
        json-validate data.json
        json-validate data.json --schema schema.json
        json-validate data.json -s schema.json --verbose
    """
    try:
        # Perform validation
        validate_json_file(json_file, schema)

        # Success message
        if schema:
            click.echo(
                click.style("✓ ", fg="green")
                + f"JSON file '{json_file}' is valid according to schema '{schema}'"
            )
        else:
            click.echo(
                click.style("✓ ", fg="green")
                + f"JSON file '{json_file}' has valid syntax"
            )

    except JSONParseError as e:
        click.echo(click.style("✗ JSON Parse Error: ", fg="red") + str(e), err=True)
        sys.exit(1)

    except JSONValidationError as e:
        click.echo(click.style("✗ Validation Error: ", fg="red") + str(e), err=True)

        if verbose and e.validation_errors:
            click.echo("\nDetailed validation errors:", err=True)
            for i, error in enumerate(e.validation_errors, 1):
                click.echo(f"  {i}. {error}", err=True)

        sys.exit(1)

    except SchemaError as e:
        click.echo(click.style("✗ Schema Error: ", fg="red") + str(e), err=True)
        sys.exit(1)

    except FileAccessError as e:
        click.echo(click.style("✗ File Error: ", fg="red") + str(e), err=True)
        sys.exit(1)

    except JSONCliError as e:
        click.echo(click.style("✗ Error: ", fg="red") + str(e), err=True)
        sys.exit(1)

    except Exception as e:
        click.echo(click.style("✗ Unexpected Error: ", fg="red") + str(e), err=True)
        if verbose:
            import traceback

            click.echo("\nTraceback:", err=True)
            traceback.print_exc()
        sys.exit(1)


@click.group()
def cli() -> None:
    """JSON CLI tools for validation and processing."""
    pass


# Add the validate command to the group for potential future expansion
cli.add_command(validate_json, name="validate")


if __name__ == "__main__":
    validate_json()
