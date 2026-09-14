$env.STARSHIP_SHELL = "nu"
def create_left_prompt [] {
    (starship prompt
     --cmd-duration
     $env.CMD_DURATION_MS
     $'--status=($env.LAST_EXIT_CODE)')
}
def create_right_prompt [] {
    with-env {
        STARSHIP_CONFIG: '/home/alice/.config/starship-right.toml'
    } {
        (starship prompt
         --right
         --cmd-duration
         $env.CMD_DURATION_MS
         $'--status=($env.LAST_EXIT_CODE)')
    }
}
def create_left_transient_prompt [] {
    "λ "
}
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = { || create_right_prompt }
$env.TRANSIENT_PROMPT_COMMAND = { || create_left_transient_prompt }
$env.PROMPT_INDICATOR = ""
$env.PROMPT_MULTILINE_INDICATOR = "- "
