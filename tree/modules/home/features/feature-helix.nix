{...}: {
  flake.modules.homeManager.feature-helix = {
    programs.helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        theme = "rose_pine";

        editor = {
          end-of-line-diagnostics = "error";
          preview-completion-insert = true;
          trim-final-newlines = true;
          completion-trigger-len = 1;
          completion-replace = true;
          jump-label-alphabet = "asdcflkjnh";
          continue-comments = false;
          line-number = "relative";
          completion-timeout = 5;
          auto-completion = true;
          bufferline = "always";
          popup-border = "all";
          auto-format = false;
          color-modes = true;
          cursorline = false;
          true-color = true;
          undercurl = true;
          scrolloff = 12;
          mouse = false;

          file-picker = {
            hidden = false;
            git-ignore = true;
          };

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          indent-guides = {
            character = "|";
            render = false;
            skip-levels = 1;
          };

          inline-diagnostics = {
            cursor-line = "hint";
            max-diagnostics = 5;
          };

          lsp = {
            display-messages = true;
            display-progress-messages = true;
          };

          soft-wrap = {
            enable = true;
          };

          statusline = {
            center = ["file-name"];
            left = ["mode" "spinner"];
            right = ["diagnostics" "position" "file-type"];
            mode = {
              insert = "|  I  |";
              normal = "|  N  |";
              select = "|  S  |";
            };
          };
        };

        keys = {
          insert = {
            C-z = "no_op";
            A-f = ["move_next_word_start"];
            A-b = ["move_prev_word_start"];
            C-f = ":format";
          };

          normal = {
            C-f = ":format";
            y = "yank_to_clipboard";
            A-N = ["search_selection" "extend_search_prev"];
            A-n = ["search_selection" "extend_search_next"];
            A-W = ["move_next_long_word_start" "delete_selection"];
            A-w = ["move_prev_long_word_start" "delete_selection"];
            C-j = [
              "extend_to_line_bounds"
              "delete_selection"
              "move_line_down"
              "paste_before"
            ];
            C-k = [
              "extend_to_line_bounds"
              "delete_selection"
              "move_line_up"
              "paste_before"
            ];
            C-n = [
              "save_selection"
              "extend_to_line_bounds"
              "yank"
              "paste_before"
              "jump_backward"
            ];
            C-N = ["save_selection" "extend_to_line_bounds" "yank" "paste_before"];
            X = "select_line_above";
            c = "change_selection_noyank";
            d = "delete_selection_noyank";
            esc = ["collapse_selection" "keep_primary_selection"];
            C-space = ":sh tmux new-window -n 'hx:filepicker' '~/.config/helix/scripts/tmux-yazi-picker.sh \"%{buffer_name}\"'";
            C-s = ":write!";

            space.w = {
              c = ":buffer-close";
              C = ":buffer-close!";
              Q = ":quit!";
              d = ":vsplit";
            };

            C-z = {
              y = ["save_selection" "select_all" "yank_to_clipboard" "jump_backward"];
              d = ["select_all" "delete_selection"];
            };
          };

          select = {
            C-f = ":format";
            C-z = "no_op";
            y = "yank_to_clipboard";
            A-N = ["search_selection" "extend_search_prev"];
            A-n = ["search_selection" "extend_search_next"];
          };
        };
      };

      languages = {
        language-server = {
          nixd = {
            command = "nixd";
          };
          tinymist = {
            command = "tinymist";
            config = {
              typstExtraArgs = ["main.typ"];
              config = {
                exportPdf = "onType";
                outputPath = "$root/target/$dir/$name";
                preview.background = {
                  enabled = true;
                  args = [
                    "--data-plane-host=127.0.0.1:23635"
                    "--invert-colors=never"
                    "--open"
                  ];
                };
              };
            };
          };
          basedpyright = {
            command = "basedpyright-langserver";
            args = ["--stdio"];
            config = {
              basedpyright.analysis = {
                diagnosticMode = "openFilesOnly";
                typeCheckingMode = "standard";
              };
              python.analysis = {
                autoImportCompletions = true;
              };
            };
          };
          ruff = {
            command = "ruff";
            config = {
              settings = {args = [];};
            };
          };
          qmlls = {
            args = ["-E" "-I" "/home/alice/.config/quickshell/"];
            command = "qmlls";
          };
        };

        language = [
          {
            name = "nix";
            auto-format = false;
            formatter = {command = "alejandra";};
            language-servers = [{name = "nixd";}];
          }
          {
            name = "typst";
            language-servers = ["tinymist"];
          }
          {
            name = "rust";
            formatter = {command = "rustfmt";};
          }
          {
            name = "python";
            scope = "source.python";
            injection-regex = "python";
            file-types = ["py" "pyi" "py3" "pyw" ".pythonstartup" ".pythonrc"];
            shebangs = ["python"];
            roots = ["." "pyproject.toml" "pyrightconfig.json"];
            comment-token = "#";
            language-servers = ["basedpyright" "ruff"];
            indent = {
              tab-width = 4;
              unit = "    ";
            };
            auto-format = true;
            formatter = {
              command = "black";
              args = ["-" "--quiet" "--line-length=79"];
            };
          }
          {
            name = "glsl";
            auto-format = false;
            file-types = ["glsl" "mustache"];
          }
          {
            name = "nu";
            auto-format = false;
            formatter = {
              command = "nufmt";
              args = ["--stdin"];
            };
          }
          {
            name = "bash";
            file-types = ["sh" "bash" "zsh" ".bashrc"];
          }
        ];
      };
    };
  };
}
