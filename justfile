nix-sync:
    sudo darwin-rebuild switch --flake ~/.config/nix#mini

nix-self-update:
    sudo nix flake update --flake ~/.config/nix

nix-full-update: nix-self-update nix-sync

# ── AWS SSM Parameter Store ──────────────────────────────────────────────────

# Write a secret to SSM (usage: just ssm-put /homelab/app/key "value")
ssm-put path value:
    AWS_PROFILE=personal-admin aws ssm put-parameter \
      --name "{{ path }}" \
      --value "{{ value }}" \
      --type SecureString \
      --overwrite \
      --region eu-central-1

# Read a secret from SSM (usage: just ssm-get /homelab/app/key)
ssm-get path:
    AWS_PROFILE=personal-admin aws ssm get-parameter \
      --name "{{ path }}" \
      --with-decryption \
      --query "Parameter.Value" \
      --output text \
      --region eu-central-1

# List all parameters under a path (usage: just ssm-list /homelab/)
ssm-list prefix="/homelab/":
    AWS_PROFILE=personal-admin aws ssm get-parameters-by-path \
      --path "{{ prefix }}" \
      --recursive \
      --query "Parameters[].Name" \
      --output table \
      --region eu-central-1

# Delete a parameter (usage: just ssm-del /homelab/app/key)
ssm-del path:
    AWS_PROFILE=personal-admin aws ssm delete-parameter \
      --name "{{ path }}" \
      --region eu-central-1
