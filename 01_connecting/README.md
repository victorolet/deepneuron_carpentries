# 01 — Connecting to a Remote HPC System

## Key concepts

- SSH opens an encrypted tunnel to the remote system
- Authentication uses **key pairs**, not passwords (on most HPC systems)
- The **SSH agent** caches your decrypted key so you only type your passphrase once per session

---

## Exercise 1: Connect to the Cluster (15 min)

### Part A — Generate your SSH key pair (on your laptop)

```bash
# Check for existing keys
ls ~/.ssh/

# Generate an Ed25519 key pair
ssh-keygen -a 100 -t ed25519 -f ~/.ssh/id_ed25519
# Enter a strong passphrase when prompted

# Confirm both files exist
ls ~/.ssh/
# Expected: id_ed25519   id_ed25519.pub
```

### Part B — Upload and connect

```bash
# Start the SSH agent
eval $(ssh-agent)

# Add your key for 8 hours
ssh-add -t 8h ~/.ssh/id_ed25519
# Enter your passphrase once here

# Connect to the cluster
ssh couxxx@setonix.pawsey.org.au

# Once connected, confirm where you are
hostname    # should print something like: login1
whoami      # should print your username

# Disconnect
exit

# Reconnect — agent should handle passphrase
ssh couxxx@setonix.pawsey.org.au
```

### What to observe

- The prompt changes from your laptop name to the cluster login node name
- After reconnecting, no passphrase is asked — the agent cached it
- `hostname` confirms you are on a remote machine, not your laptop

---

## Platform notes for the SSH agent

**macOS** — persist the key across reboots:
```bash
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

**Windows (WSL)** — agent usually starts automatically; check with:
```bash
ssh-add -l
```

**Linux** — add to `~/.bashrc` for automatic agent start:
```bash
echo 'eval $(ssh-agent)' >> ~/.bashrc
echo 'ssh-add -t 8h ~/.ssh/id_ed25519' >> ~/.bashrc
source ~/.bashrc
```
