# test3

This project uses an autonomous, multi-agent project workflow with a built-in **Review-Before-Commit** system.

## Workflow Overview

1.  **Planning**: The `planner` agent breaks down requirements into a granular roadmap.
2.  **Implementation**: The `developer` agent builds features according to the roadmap.
3.  **Verification**: The `tester` agent verifies the code.
4.  **Review**: Changes can be reviewed and accepted/rejected using the `review-changes.ps1` script.

## How to Review Changes

Run the following command in PowerShell to review pending changes:

```powershell
.\review-changes.ps1
```

- **Accept**: Commits the changes to the local repository.
- **Reject**: Rolls back all changes to the last committed state.
