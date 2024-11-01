# ~/.zsh_plugins/autoenv.zsh

# Store the last directory with an active environment
last_venv_dir=""

auto_activate_env() {
    # If there’s an active environment and we've left the main or subdirectory, deactivate it
    if [[ -n "$VIRTUAL_ENV" && "$PWD" != "$last_venv_dir"* ]]; then
        deactivate
        last_venv_dir=""
    fi

    # Check for the presence of the environment activation file in .venv in the main directory
    if [ -f "./.venv/bin/activate" ]; then
        # Only activate if not already activated
        if [[ -z "$VIRTUAL_ENV" ]]; then
            echo "Virtual environment detected, activating..."
            source ./.venv/bin/activate
            last_venv_dir="$PWD"
        fi
    fi
}

# Run the function whenever you change directories
autoload -U add-zsh-hook
add-zsh-hook chpwd auto_activate_env

# Run the function on shell startup (for the initial directory)
auto_activate_env
