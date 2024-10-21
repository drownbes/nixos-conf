let
  drownbes = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOakSKgDZE827GV8hWVjTOzdh4K0uVug2SExwy+8owbN";
  pc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEXOS1IHi4ENDUCA1qICdczU1z/kCCvUNdJnt4a4yYYN";
  keys = [drownbes pc];
in {
  "openai_token.age".publicKeys = keys;
}
