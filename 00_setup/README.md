# 00 — Pre-Workshop Setup

Complete these steps **on your own laptop** before the workshop begins.

---

## 1. Terminal access

| OS | Recommended terminal |
|----|---------------------|
| Linux | Any terminal emulator |
| macOS | Terminal (built-in) or iTerm2 |
| Windows | WSL2 + Ubuntu, MobaXterm, or PuTTY |

---

## 2. Check for an existing SSH key

```bash
ls ~/.ssh/
```

If you see `id_ed25519` and `id_ed25519.pub`, you already have an Ed25519 key pair — skip step 3.

---

## 3. Generate an SSH key pair

Run this on your **local machine**:

```bash
ssh-keygen -a 100 -t ed25519 -f ~/.ssh/id_ed25519
```

- Enter a **strong passphrase** when prompted (do not leave it empty)
- Two files will appear:
  - `~/.ssh/id_ed25519` — your **private** key (never share this)
  - `~/.ssh/id_ed25519.pub` — your **public** key (safe to share)

---

## 4. Upload your public key

Follow the link provided by your instructor to upload `~/.ssh/id_ed25519.pub` to the Pawsey portal.

---

## 5. Test your connection

```bash
ssh couxxx@setonix.pawsey.org.au
```

Replace `couxxx` with your actual username. You should see a login banner and a shell prompt on the remote system.

---

## 6. Clone this repository (on the cluster)

Once connected:

```bash
git clone https://github.com/YOUR-ORG/hpc-workshop.git
cd hpc-workshop
```

---

## You are ready when you can:

- [ ] Open a terminal on your laptop
- [ ] SSH into the cluster without errors
- [ ] See a remote shell prompt (`[couxxx@login1 ~]$`)
- [ ] Run `sinfo` and see partition output
