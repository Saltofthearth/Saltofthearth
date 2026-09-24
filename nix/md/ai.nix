# MD - Artificial Intelligence & Speech
{ pkgs }:

{
  description = "@md/ai: Autonomous agent tooling, LLM execution, local speech recognition";
  packages = with pkgs; [
    whisper-cpp        # High-performance speech-to-text inference
    ollama             # Local LLM runner
  ];
}
