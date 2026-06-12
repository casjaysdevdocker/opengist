# opengist

A containerized [OpenGist](https://github.com/thomiceli/opengist) — a self-hosted pastebin powered by Git. Create, share, and fork code snippets with full Git history, HTTP clone, SSH push/pull, and OAuth2 login via GitHub, GitLab, Gitea, or OpenID Connect. Built on Alpine Linux with SQLite storage and no external database required.

---

## 📦 Install

### Via dockermgr (recommended)

```shell
sudo bash -c "$(curl -q -LSsf "https://github.com/systemmgr/installer/raw/main/install.sh")"
sudo systemmgr --config && sudo systemmgr install scripts
dockermgr update opengist
```

### Manual docker run

```shell
docker run -d \
  --restart always \
  --name casjaysdevdocker-opengist-latest \
  --hostname opengist \
  -e TZ=${TIMEZONE:-America/New_York} \
  -v /var/lib/srv/$USER/docker/casjaysdevdocker/opengist/latest/volumes/data:/data:z \
  -v /var/lib/srv/$USER/docker/casjaysdevdocker/opengist/latest/volumes/config:/config:z \
  -p 172.17.0.1:80:80 \
  -p 172.17.0.1:7823:7823 \
  casjaysdevdocker/opengist:latest
```

### docker-compose

```yaml
services:
  opengist:
    image: casjaysdevdocker/opengist:latest
    container_name: casjaysdevdocker-opengist
    hostname: opengist
    environment:
      - TZ=America/New_York
    volumes:
      - "/var/lib/srv/$USER/docker/casjaysdevdocker/opengist/latest/volumes/data:/data:z"
      - "/var/lib/srv/$USER/docker/casjaysdevdocker/opengist/latest/volumes/config:/config:z"
    ports:
      - "172.17.0.1:80:80"
      - "172.17.0.1:7823:7823"
    restart: always
```

---

## ⚙️ Configuration

### Volumes

| Path | Purpose |
|------|---------|
| `/config` | Runtime configuration (auto-generated on first start) |
| `/data` | Gist repositories, SQLite database, logs, and index |

### Ports

| Port | Protocol | Purpose |
|------|----------|---------|
| `80` | HTTP | Web UI and HTTP Git clone/pull |
| `7823` | TCP | Built-in SSH server for Git push/pull |

### Environment variables

| Variable | Default | Description |
|----------|---------|-------------|
| `TZ` | `America/New_York` | Container timezone |
| `HOSTNAME` | `casjaysdev-opengist` | Sets the `external-url` in opengist config |
| `SERVER_NAME` / `FULL_DOMAIN_NAME` | — | Override hostname for external URL |
| `OPENGIST_APPNAME_ENABLED` | `yes` | Set to `no` to disable the service |
| `OPENGIST_ROOT_USER_NAME` | — | Initial admin username |
| `OPENGIST_ROOT_PASS_WORD` | — | Initial admin password |
| `OPENGIST_USER_NAME` | — | Initial normal user name |
| `OPENGIST_USER_PASS_WORD` | — | Initial normal user password |
| `DEBUGGER` | — | Set to `on` to enable shell-level debug tracing |

### Runtime config overrides

Place a shell script at `/config/env/opengist.sh` inside the container (or mount it as a file) to override any variable at runtime without rebuilding the image. A template is written on first start.

### OAuth2

After first start, edit `/config/opengist/config.yaml` to add OAuth2 credentials:

```yaml
github.client-key: <your-key>
github.secret:     <your-secret>

gitlab.client-key: <your-key>
gitlab.secret:     <your-secret>
gitlab.url:        https://gitlab.com/

gitea.client-key:  <your-key>
gitea.secret:      <your-secret>
gitea.url:         https://your-gitea-instance/

oidc.client-key:      <your-key>
oidc.secret:          <your-secret>
oidc.discovery-url:   https://auth.example.com/.well-known/openid-configuration
```

OAuth2 callback URLs must follow the pattern:
`http://<opengist-url>/oauth/<github|gitlab|gitea|openid-connect>/callback`

---

## 🛠️ Development

### Prerequisites

- Docker with `buildx` support
- `git`

### Get source

```shell
git clone "https://github.com/casjaysdevdocker/opengist" \
  "$HOME/Projects/github/casjaysdevdocker/opengist"
cd "$HOME/Projects/github/casjaysdevdocker/opengist"
```

Or via dockermgr:

```shell
dockermgr download src casjaysdevdocker/opengist
```

### Build the image

```shell
buildx
```

The build downloads the latest OpenGist release binary from GitHub at build time and bundles it into the image.

---

## 📄 License

WTFPL — see [LICENSE.md](LICENSE.md)

🤖 casjay: [Github](https://github.com/casjay) 🤖  
⛵ casjaysdevdocker: [Github](https://github.com/casjaysdevdocker) [Docker](https://hub.docker.com/u/casjaysdevdocker) ⛵
