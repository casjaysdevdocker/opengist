# TODO.AI.md

Pre-existing script-lint findings on `rootfs/usr/local/etc/docker/functions/entrypoint.sh`,
found while fixing the container restart-loop bug. Not caused by that fix; deferred here
since they are unrelated cleanup, not a functional regression. This file is fully regenerated
from the shared upstream template (`casjay-dotfiles/scripts`) on every template-update run, so
these findings must be fixed upstream in the template, not patched locally in this repo — a
local patch would be silently overwritten by the next `AI.md` runbook run.

Read: AI.md (Docker Template Update Runbook), Step 3/5

- [ ] `grep` calls missing `--` before the pattern (lines 80, 92, 105, 111, 139, 140, 141, 166,
      167, 169, 178, 229, 388, 693, 749, 759, 790, 792, 803, 820, 863, 909, 920, 944) — add `--`
      per `~/.claude/memory/tool_conventions.md`
- [ ] `__fix_permissions()` (line 744): `change_user`/`change_group` assigned without `local`
- [ ] `__initialize_db_users()` (lines 1380-1385): `db_normal_user`, `db_normal_pass`,
      `db_admin_user`, `db_admin_pass` assigned without `local`
- [ ] `__initialize_custom_bin_dir()` (line 1428): `create_bin_name` assigned without `local`
- [ ] No `VERSION=` assignment in body to match the `##@Version` header (functions library —
      confirm whether versioning is required for this file type before adding)
