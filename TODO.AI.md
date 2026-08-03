# TODO.AI.md

Pre-existing script-lint findings on `rootfs/usr/local/etc/docker/functions/entrypoint.sh`,
found while fixing the container restart-loop bug. Not caused by that fix; deferred here
since they are unrelated cleanup, not a functional regression.

- [ ] `grep` calls missing `--` before the pattern (lines 80, 92, 111, 141, 169, 685, 741,
      751, 812, 855, 901, 912, 936) — add `--` per `~/.claude/memory/tool_conventions.md`
- [ ] `__fix_permissions()` (line 737-738): `change_user`/`change_group` assigned without `local`
- [ ] `__initialize_db_users()` (lines 1370-1373): `db_normal_user`, `db_normal_pass`,
      `db_admin_user`, `db_admin_pass` assigned without `local`
- [ ] `__initialize_custom_bin_dir()` (line 1416): `create_bin_name` assigned without `local`
- [ ] No `VERSION=` assignment in body to match the `##@Version` header (functions library —
      confirm whether versioning is required for this file type before adding)
