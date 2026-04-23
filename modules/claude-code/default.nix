{ pkgs, config, ... }:
{
  programs.claude-code = {
    enable = true;
    # settings.hooks = {
    #   "SessionStart" = [
    #     {
    #       hooks = [
    #         {
    #           type = "command";
    #           command = ''
    #             #!/usr/bin/env bash
    #             ${config.programs.fd.package}/bin/fd -d 3 -x sh -c 'echo "# $1" && ${pkgs.zat}/bin/zat "$1" || true' _ {}
    #           '';
    #         }
    #       ];
    #     }
    #   ];
    # };
    rules = {
      zat = ''
        ### zat

        A code outline viewer that shows exported symbol signatures with line numbers.

        Prefer `zat` over `cat`/`Read` when you need signatures, not full implementation. Use the line numbers in the output to `Read(offset, limit)` into specific sections.

        Supported languages: C, C++, C#, Go, Haskell, Java, JavaScript, Kotlin, Markdown, Python, Ruby, Rust, Swift, TypeScript/TSX

        `zat` exits with code 1 for unsupported languages.
      '';
      fd = ''
        ### fd

        Use `fd` instead of `find`.
      '';
    };
  };
}
