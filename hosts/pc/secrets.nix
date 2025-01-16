{
  config,
  pkgs,
  inputs,
  ...
}: {
  age.secrets.openai_token = {
    file = ../../secrets/openai_token.age;
    owner = "drownbes";
    mode = "440";
  };

  age.secrets.grok_token = {
    file = ../../secrets/grok_token.age;
    owner = "drownbes";
    mode = "440";
  };
  age.secrets.anthropic_token = {
    file = ../../secrets/anthropic_token.age;
    owner = "drownbes";
    mode = "440";
  };
  environment.variables = {
    OPENAI_API_KEY = "$(cat ${config.age.secrets.openai_token.path})";
    GROQ_API_KEY = "$(cat ${config.age.secrets.grok_token.path})";
    ANTHROPIC_API_KEY = "$(cat ${config.age.secrets.anthropic_token.path})";
  };

  environment.systemPackages = with pkgs; [
    inputs.agenix.packages.x86_64-linux.default
  ];
}
