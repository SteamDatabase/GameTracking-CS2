// @ts-ignore
import { Instance } from "server/serverpointentity";
// Run me with ent_create point_script { "script" "source_ts/tests//compatscript.vts" }
Instance.Msg("Compat Test");
Instance.Msg(JSON.stringify(Object.keys(Instance)));
