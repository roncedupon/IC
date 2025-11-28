<!-- Auto-generated guidance for AI coding agents. Edit with care. -->
# Repo-specific Copilot instructions

Purpose: give an AI agent immediate, actionable context for working in this mixed SystemVerilog/UVM + tools repository.

- Project snapshot: this repo is a collection of UVM/SystemVerilog examples, verification tests, and supporting C/Python tooling. Key areas: `basic/` (many `uvm_basic_*` examples), `uvm_source/`, `uvm_lib/`, `sva/`, `Test/`, and `ibex_submodule` (RISCV/sw artifacts). There are also `C/`, `cpp/`, and `python/` folders for helper tools.

- Typical simulators & commands (copy exact examples when reproducing):
  - VCS (from `Instructions.txt`):
    - `vcs -full64 router.v Tb.sv -sverilog -timescale=1ns/1ps -debug_accesss+all -top Tb`
    - `./simv -gui &`
  - iverilog (lint/run examples in `iveriloginst.txt`):
    - include UVM source paths with `-I` and use `--sv --lint-only --language 1800-2012 --Wall -y <dir>` for linting.

- Filelists and top-level tests:
  - Look for `filelist.f` files (examples: `sva/filelist.f`, `Test/filelist.f`) — simulators often consume these.
  - Top-level testbenches are commonly named `Tb.sv` or `test.sv`. When locating the DUT/test, `grep -R "Tb.sv\|test.sv"` is effective.

- UVM & include conventions:
  - `iveriloginst.txt` shows local UVM includes pointing to a UVM-1.2 checkout (`-I /home/dy/Softwares/Envs/uvm-1.2/...`). Agents should not hardcode that path — prefer reading and updating the file before running.
  - Many examples follow an incremental naming pattern: `uvm_basic_V1_Success`, `uvm_basic_V2_tlm`, etc. Use these as canonical examples for modifications or new tests.

- Build / run guidance for agents:
  - Prefer running `--lint-only` with iverilog first to catch syntax issues.
  - For a quick simulation reproduce the steps in `Instructions.txt` for the matching directory (run VCS compile then `./simv`).
  - There is no single CI config or centralized Makefile across all examples — check the target subdirectory for a `makefile` or scripts.

- Debugging artifacts and post-sim logs:
  - Check `verdiLog/`, `post_sim/`, and `uvm_source/` for waveform, log, and post-processing outputs.

- Project-specific patterns agents should follow:
  - When adding or editing a testbench, update or add a `filelist.f` in the test directory.
  - Reuse the `uvm_basic_*` folders as templates: they typically show step-by-step UVM features and are the best places to copy structure (env, agent, sequence, test, host/testbench files).
  - Keep UVM compatibility in mind (repo references UVM-1.2). Prefer using UVM idioms used in `basic/uvm_basic_V*_` folders.

- Where to look for more context (quick grep targets):
  - `Instructions.txt` — example VCS commands
  - `iveriloginst.txt` — typical iverilog include flags and language options
  - `basic/`, `uvm_source/`, `uvm_lib/`, `Test/`, `sva/` — canonical examples and filelists

- When in doubt (actionable steps for the agent):
  1. Search for `Tb.sv` / `test.sv` in the repo to find the top-level test.
 2. Inspect `filelist.f` or `makefile` in that folder to discover compile order and include flags.
 3. Run iverilog lint (`--lint-only`) with includes from `iveriloginst.txt` after updating paths.
 4. If lint passes, run the VCS command pattern from `Instructions.txt` adjusted to the test’s filelist.

- Feedback: If anything above is unclear or you want the agent to follow stricter guardrails (e.g., run tests, open PRs), reply with specifics and I will iterate.
