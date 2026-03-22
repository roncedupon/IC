#!/usr/bin/env python3
"""
run_cmd_creater.py - Generate regression run commands from JSON testlist

This script reads a JSON testlist file and generates run commands based on a template.
"""

import json
import argparse
from datetime import datetime
from pathlib import Path


def load_testlist(json_file):
    """Load testlist from JSON file."""
    with open(json_file, 'r', encoding='utf-8') as f:
        return json.load(f)


def generate_run_cmd(test_config, template_params):
    """
    Generate run command for a single test configuration.
    
    Args:
        test_config: Dictionary containing test configuration
        template_params: Dictionary containing template parameters
    
    Returns:
        Generated run command string
    """
    # Extract template parameters with defaults
    bsub_cmd = template_params.get('bsub_cmd', 'bsub -q to2 -Is ')
    job_num = template_params.get('job_num', 1)
    extra_cmd = template_params.get('extra_cmd', '')
    Date = template_params.get('Date', datetime.now().strftime('%Y%m%d'))
    
    # Extract test-specific parameters
    tc_list = test_config.get('tc_list', '')
    # Extract simdir from tc_list if not specified
    if 'simdir' in test_config:
        simdir = test_config['simdir']
    else:
        # Extract filename from tc_list path
        import os
        simdir = os.path.basename(tc_list) if tc_list else 'default_sim'
    pre_setup = test_config.get('pre_setup', '')
    test_extra_cmd = test_config.get('extra_cmd', '')
    subcmd = test_config.get('subcmd', [])
    
    # Use test-specific extra_cmd if provided, otherwise use template extra_cmd
    final_extra_cmd = test_extra_cmd if test_extra_cmd else extra_cmd
    
    # Generate commands
    commands = []
    
    # Generate main command
    main_cmd = (
        f"{bsub_cmd} run -l {tc_list} \t "
        f"-sim \"-cm line+cond+fsm+tgl+branch+assert \" "
        f"-simdir regression/regression_{Date}/{simdir} "
        f"-g  -p {job_num}  -seed_offset {Date} {final_extra_cmd} "
        f"-b \"{bsub_cmd} timeout 2400m \"&"
    )
    
    # Add pre_setup before main command if specified
    if pre_setup:
        main_cmd = f"{pre_setup} && {main_cmd}"
    
    commands.append(main_cmd)
    
    # Generate subcommands if specified
    if subcmd:
        for sc in subcmd:
            # Determine subcommand parameters
            if isinstance(sc, dict):
                # Subcommand with custom parameters
                sub_cmd_str = sc.get('cmd', '')
                sub_pre_setup = sc.get('pre_setup', pre_setup)
                sub_extra_cmd = sc.get('extra_cmd', test_extra_cmd)
                sub_final_extra_cmd = sub_extra_cmd if sub_extra_cmd else extra_cmd
            else:
                # Simple subcommand string
                sub_cmd_str = sc
                sub_pre_setup = pre_setup
                sub_final_extra_cmd = final_extra_cmd
            
            sub_cmd = (
                f"{bsub_cmd} run -l {tc_list} \t "
                f"-sim \"-cm line+cond+fsm+tgl+branch+assert \" "
                f"-simdir regression/regression_{Date}/{simdir} "
                f"-g  -p {job_num}  -seed_offset {Date} {sub_final_extra_cmd} {sub_cmd_str} "
                f"-b \"{bsub_cmd} timeout 2400m \"&"
            )
            if sub_pre_setup:
                sub_cmd = f"{sub_pre_setup} && {sub_cmd}"
            commands.append(sub_cmd)
    
    return '\n'.join(commands)


def main():
    parser = argparse.ArgumentParser(
        description='Generate regression run commands from JSON testlist'
    )
    parser.add_argument(
        '-j', '--json',
        default=None,
        help='Path to JSON testlist file (default: testlist.json in script directory)'
    )
    parser.add_argument(
        '-o', '--output',
        default='run_commands.sh',
        help='Output file for generated commands (default: run_commands.sh)'
    )
    parser.add_argument(
        '--bsub-cmd',
        default='bsub -q to2 -Is ',
        help='BSUB command (default: bsub -q to2)'
    )

    parser.add_argument(
        '--job-num',
        type=int,
        default=15,
        help='Number of parallel jobs (default: 10)'
    )
    parser.add_argument(
        '--extra-cmd',
        default='',
        help='Extra command parameters'
    )
    parser.add_argument(
        '--date',
        default=datetime.now().strftime('%Y%m%d'),
        help='Date string for directory naming (default: current date)'
    )
    
    args = parser.parse_args()
    
    # Determine JSON file path
    import os
    if args.json is None:
        # Use default testlist.json in script directory
        script_dir = os.path.dirname(os.path.abspath(__file__))
        json_file = os.path.join(script_dir, 'testlist.json')
        if not os.path.exists(json_file):
            print(f"Error: Default testlist.json not found in {script_dir}")
            return
        print(f"Using default testlist: {json_file}")
    else:
        json_file = args.json
    
    # Load testlist
    testlist = load_testlist(json_file)
    
    # Prepare template parameters
    template_params = {
        'bsub_cmd': args.bsub_cmd,
        'job_num': args.job_num,
        'extra_cmd': args.extra_cmd,
        'Date': args.date
    }
    
    # Generate commands for all tests
    commands = []
    for test_config in testlist.get('tests', []):
        cmd = generate_run_cmd(test_config, template_params)
        commands.append(cmd)
        test_name = test_config.get('tc_list', 'unnamed')
        print(f"Generated command for: {test_name}")
    
    # Write commands to output file
    with open(args.output, 'w', encoding='utf-8') as f:
        f.write('#!/bin/bash\n')
        f.write(f'# Generated by run_cmd_creater.py\n')
        f.write(f'# Date: {args.date}\n')
        f.write(f'# Total tests: {len(commands)}\n\n')
        
        for i, (cmd, test_config) in enumerate(zip(commands, testlist.get('tests', [])), 1):
            test_name = test_config.get('tc_list', 'unnamed')
            f.write(f'# Test {i}: {test_name}\n')
            f.write(f'{cmd}\n\n')
    
    print(f"\nGenerated {len(commands)} commands to: {args.output}")
    print(f"Make the script executable: chmod +x {args.output}")


if __name__ == '__main__':
    main()
