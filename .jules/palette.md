## 2025-03-25 - Whiptail Checklists lack visual cues for keyboard interactions
**Learning:** CLI UI frameworks like whiptail often lack intuitive visual cues for their keyboard interactions. For example, many users don't realize they must press `<Space>` to toggle items in a `--checklist` before pressing `<Enter>`, leading them to accidentally skip all selections.
**Action:** Always include explicit, inline keyboard instructions (like `(Press <Space> to toggle, <Enter> to confirm)`) in the prompt or title of CLI interactive menus that rely on specific keystrokes.

## 2025-03-25 - Handle Empty States in CLI Prompts
**Learning:** When prompting users to select from a dynamic list in CLI scripts, displaying the prompt when the list is empty creates a confusing and broken user experience.
**Action:** Always check if a dynamic list is empty before prompting the user to select from it. If it is empty, exit gracefully and provide actionable instructions on how to populate the list instead of showing a non-functional prompt.

## 2025-03-29 - Distinguish Cancel from Empty State in CLI Checklists
**Learning:** When using CLI frameworks like whiptail, users expect explicit feedback when they abort an action (e.g., `<Cancel>` or `ESC`). Silent exits make the UI feel unresponsive. Furthermore, aborting a prompt is semantically different from submitting an empty checklist, and confusing the two leads to duplicate or conflicting warning messages.
**Action:** Always intercept whiptail's exit code `1` to log a clear "Selection cancelled." message. Handle empty checklist submissions separately without triggering the cancellation flow.
