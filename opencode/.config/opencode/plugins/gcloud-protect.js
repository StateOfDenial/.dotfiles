export const GcloudReadOnly = async (ctx) => {
    return {
        "tool.execute.before": async (input, output) => {
            if (input.tool === "bash") {
                const cmd = output.args.command || "";
                if (cmd.includes("gcloud")) {
                    if (cmd.includes(" create ") || cmd.includes(" update ") ||
                        cmd.includes(" delete ") || cmd.includes(" remove ") ||
                        cmd.includes(" set ") || cmd.includes(" add-iam-policy-binding ")) {
                        throw new Error(`Blocked unsafe gcloud command: ${cmd}`);
                    }
                }
            }
        },
    }
}
