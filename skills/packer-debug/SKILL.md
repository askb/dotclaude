<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
# Packer Debug

Debug Packer build failures in OpenStack environments.

## When to Use

Run this skill when a Packer image build fails.

## Steps

1. **Check build output** — Review Packer error messages
   - Look for SSH connection timeouts
   - Check provisioner script failures
   - Review OpenStack API errors

2. **Verify resources** — Check OpenStack state
   - `openstack server list` — is the build VM still running?
   - `openstack server show <id>` — check status and addresses
   - `openstack console log show <id>` — check cloud-init output

3. **Check connectivity** — Test bastion path
   - `tailscale status` — VPN connected?
   - `tailscale ping <bastion>` — bastion reachable?
   - `ssh -o ProxyCommand="ssh -W %h:%p <bastion>" <target>` — can reach target?

4. **Debug with verbose logging**
   - `PACKER_LOG=1 packer build ...` — enable debug output
   - Check `~/.ssh/known_hosts` for stale entries
   - Verify `clouds.yaml` authentication

5. **Clean up** — Remove orphaned resources
   - `openstack server delete <id>`
   - `openstack floating ip delete <ip>`
   - Check for orphaned ports and volumes

## Common Failures

| Symptom | Likely Cause | Fix |
|---------|-------------|-----|
| SSH timeout | Bastion unreachable | Check Tailscale VPN |
| Auth error | Expired credentials | Regenerate OAuth keys |
| Build VM missing | Quota exceeded | Clean up old resources |
| Provisioner fail | Script error | Check script with shellcheck |
