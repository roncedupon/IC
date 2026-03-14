import re
import sys
from pathlib import Path
from typing import Optional, List, Dict, Tuple

class LogRangeExtractor:
    """
    Universal log range extractor - extract all lines between start and end patterns
    """
    def __init__(self, log_file_path: str):
        self.log_file_path = Path(log_file_path)
        # Don't check if file exists here - we'll check when actually using it

    def extract_range(
        self,
        start_pattern: str,
        end_pattern: str,
        output_file: str = "extracted_logs.log",
        case_sensitive: bool = True,
        include_boundaries: bool = True,
        stop_after_first: bool = False
    ) -> List[str]:
        """
        Extract lines between start and end patterns
        
        Args:
            start_pattern: Pattern to match start line (supports regex)
            end_pattern: Pattern to match end line (supports regex, including multi-line)
            output_file: Path to save extracted results
            case_sensitive: Whether to enable case-sensitive matching
            include_boundaries: Whether to include start/end lines in results
            stop_after_first: Stop extraction after first matched range
            
        Returns:
            List of extracted lines
        """
        # Compile regex patterns with MULTILINE to support line anchors and DOTALL for multi-line patterns
        flags = re.MULTILINE | re.DOTALL if case_sensitive else re.MULTILINE | re.DOTALL | re.IGNORECASE
        start_re = re.compile(start_pattern, flags)
        end_re = re.compile(end_pattern, flags)

        extracted_content = []

        # Check if log file exists
        if not self.log_file_path.exists():
            raise FileNotFoundError(f"Log file not found: {self.log_file_path.absolute()}")
        
        # Read entire log file into memory
        with open(self.log_file_path, 'r', encoding='utf-8', errors='ignore') as f:
            log_content = f.read()

        # Find all start positions
        start_matches = list(start_re.finditer(log_content))

        for start_match in start_matches:
            # Find the first end match after the start match
            start_pos = start_match.start()
            end_match = end_re.search(log_content[start_pos:])

            if end_match:
                end_pos = start_pos + end_match.end()
                # Extract the range
                extracted_segment = log_content[start_pos:end_pos]
                extracted_content.append(extracted_segment)

                if stop_after_first:
                    break

        # Combine all extracted segments
        final_content = ''.join(extracted_content)
        # Split into lines for counting and return
        extracted_lines = final_content.splitlines()

        # Save results to file
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(final_content)

        print(f"Extraction completed! Total {len(extracted_lines)} lines extracted")
        print(f"Results saved to: {Path(output_file).absolute()}")
        
        return extracted_lines

    def realtime_extract(
        self,
        start_pattern: str,
        end_pattern: str,
        case_sensitive: bool = True,
        include_boundaries: bool = True
    ) -> None:
        """
        Real-time extract log range (for continuously writing logs)
        """
        flags = 0 if case_sensitive else re.IGNORECASE
        start_re = re.compile(start_pattern, flags)
        end_re = re.compile(end_pattern, flags)

        in_range = False
        print(f"Starting real-time log extraction (Press Ctrl+C to stop):\n")

        try:
            with open(self.log_file_path, 'r', encoding='utf-8', errors='ignore') as f:
                # Move to end of file to monitor new content only
                f.seek(0, 2)
                
                while True:
                    line = f.readline()
                    if not line:
                        continue
                    
                    stripped_line = line.rstrip('\n')
                    
                    # Start matching
                    if start_re.search(stripped_line):
                        in_range = True
                        if include_boundaries:
                            print(stripped_line)
                        continue

                    # End matching
                    if in_range and end_re.search(stripped_line):
                        if include_boundaries:
                            print(stripped_line)
                        in_range = False
                        continue

                    # Print lines in range
                    if in_range:
                        print(stripped_line)

        except KeyboardInterrupt:
            print("\n\nReal-time extraction stopped")
        except Exception as e:
            print(f"\nReal-time extraction failed: {str(e)}")

    def extract_from_config(
        self,
        config_file: str,
        output_dir: str = ".",
        case_sensitive: bool = True,
        include_boundaries: bool = True
    ) -> Dict[str, List[str]]:
        """
        Extract multiple log ranges based on configuration file
        
        Args:
            config_file: Path to configuration file
            output_dir: Directory to save extracted logs
            case_sensitive: Whether to enable case-sensitive matching
            include_boundaries: Whether to include start/end lines in results
            
        Returns:
            Dict of output filenames to extracted lines
        """
        # Parse configuration file
        global_log_file, blocks = self._parse_config_file(config_file)
        
        # Create output directory if it doesn't exist
        output_path = Path(output_dir)
        output_path.mkdir(parents=True, exist_ok=True)
        
        results = {}
        range_idx = 1
        
        # Determine the log file to use
        if global_log_file:
            log_file_to_use = global_log_file
            print(f"Using log file from config: {log_file_to_use}")
        else:
            raise ValueError("Config error: No log file specified. Please add 'log:path/to/log.log' to the config file.")
        
        # Create extractor for the log file
        block_extractor = LogRangeExtractor(log_file_to_use)
        
        # Process each block
        for block_idx, block in enumerate(blocks, 1):
            print(f"\n=== Processing Block {block_idx} ===")
            print(f"Number of ranges: {len(block['extraction_ranges'])}")
            
            # Process each extraction range in the block
            for start_pattern, end_pattern in block['extraction_ranges']:
                # Generate output filename
                output_file = output_path / f"extracted_block{block_idx:02d}_range{range_idx:03d}.log"
                
                print(f"\n--- Extracting range {range_idx} ---\n")
                print(f"Start pattern: {start_pattern}")
                print(f"End pattern: {end_pattern}")
                print(f"Output file: {output_file.absolute()}")
                
                # Extract the range
                extracted_lines = block_extractor.extract_range(
                    start_pattern=start_pattern,
                    end_pattern=end_pattern,
                    output_file=str(output_file),
                    case_sensitive=case_sensitive,
                    include_boundaries=include_boundaries,
                    stop_after_first=False
                )
                
                results[str(output_file)] = extracted_lines
                range_idx += 1
        
        print(f"\n=== All extractions completed ===")
        print(f"Total {range_idx - 1} ranges extracted across {len(blocks)} blocks")
        return results
    
    def _parse_config_file(self, config_file: str) -> Tuple[str, List[Dict]]:
        """
        Parse configuration file
        
        Config file format:
        # Global log path (optional)
        log:path/to/log.log
        
        # Block 1
        start:aaa
        end:bbb
        start:ccc
        end:ddd
        
        # Block 2
        start:eee
        end:fff
        
        Returns:
            Tuple of (global_log_file, blocks), where blocks is a list of blocks each containing extraction_ranges
        """
        config_path = Path(config_file)
        if not config_path.exists():
            raise FileNotFoundError(f"Config file not found: {config_path.absolute()}")
        
        global_log_file = None
        blocks = []
        current_block = None
        current_start = None
        
        with open(config_path, 'r', encoding='utf-8', errors='ignore') as f:
            for line_num, line in enumerate(f, 1):
                stripped_line = line.strip()
                
                # Skip empty lines and comments
                if not stripped_line or stripped_line.startswith('#'):
                    # Start a new block on blank line after comments
                    if not stripped_line and current_block is not None:
                        # Finalize current block
                        if current_start is not None:
                            raise ValueError(f"Config error at line {line_num}: Missing 'end:' for previous 'start:'")
                        if current_block['extraction_ranges']:
                            blocks.append(current_block)
                        current_block = None
                    continue
                
                # Handle global log file specification (only allowed before first block)
                if stripped_line.startswith('log:') and not blocks and current_block is None:
                    # Extract log file path
                    log_path = stripped_line.split(':', 1)[1].strip()
                    # Remove quotes if present
                    if (log_path.startswith('"') and log_path.endswith('"')) or \
                       (log_path.startswith("'") and log_path.endswith("'")):
                        log_path = log_path[1:-1]
                    global_log_file = log_path
                
                # Handle possible variations in start keyword (e.g., 'satrt' typo)
                elif stripped_line.startswith('start:') or stripped_line.startswith('satrt:'):
                    if current_start is not None:
                        raise ValueError(f"Config error at line {line_num}: Missing 'end:' for previous 'start:'")
                    # Start a new block if we don't have one
                    if current_block is None:
                        current_block = {
                            'extraction_ranges': []
                        }
                    # Extract pattern, handling quotes and r"" format
                    pattern = stripped_line.split(':', 1)[1].strip()
                    # Remove quotes if present
                    if (pattern.startswith('"') and pattern.endswith('"')) or \
                       (pattern.startswith("'") and pattern.endswith("'")):
                        pattern = pattern[1:-1]
                    # Remove r prefix if present (for raw strings)
                    if pattern.startswith('r"') and pattern.endswith('"'):
                        pattern = pattern[2:-1]
                    # Handle escape sequences
                    pattern = pattern.encode('utf-8').decode('unicode_escape')
                    current_start = pattern
                
                # Parse end pattern
                elif stripped_line.startswith('end:'):
                    if current_start is None:
                        raise ValueError(f"Config error at line {line_num}: 'end:' without corresponding 'start:'")
                    # Extract pattern, handling quotes and r"" format
                    pattern = stripped_line.split(':', 1)[1].strip()
                    # Remove quotes if present
                    if (pattern.startswith('"') and pattern.endswith('"')) or \
                       (pattern.startswith("'") and pattern.endswith("'")):
                        pattern = pattern[1:-1]
                    # Remove r prefix if present (for raw strings)
                    if pattern.startswith('r"') and pattern.endswith('"'):
                        pattern = pattern[2:-1]
                    # Handle escape sequences
                    pattern = pattern.encode('utf-8').decode('unicode_escape')
                    end_pattern = pattern
                    if current_block is None:
                        current_block = {
                            'extraction_ranges': []
                        }
                    current_block['extraction_ranges'].append((current_start, end_pattern))
                    current_start = None
                
                else:
                    raise ValueError(f"Config error at line {line_num}: Invalid line format. Expected 'log:', 'start:', or 'end:'")
        
        # Finalize the last block
        if current_block is not None:
            if current_start is not None:
                raise ValueError("Config error: Missing 'end:' for last 'start:'")
            if current_block['extraction_ranges']:
                blocks.append(current_block)
        
        if not blocks:
            raise ValueError("Config error: No extraction blocks found")
        
        print(f"Parsed {len(blocks)} blocks from config file")
        if global_log_file:
            print(f"Global log file: {global_log_file}")
        for i, block in enumerate(blocks, 1):
            print(f"Block {i}: ranges={len(block['extraction_ranges'])}")
        
        return global_log_file, blocks

def extract_to_csv(
    log_file_path: str,
    csv_file: str = "extracted_data.csv",
    data_pattern: str = r"\[([^]]+)\]\s*=\s*([0-9]+)\s*\(hex:\s*(0x[0-9a-fA-F]+)\)",
    case_sensitive: bool = True
) -> None:
    """
    Extract structured data to CSV (universal for key-value format logs)
    """
    flags = 0 if case_sensitive else re.IGNORECASE
    data_re = re.compile(data_pattern, flags)
    
    csv_lines = ["field_name,value,hex_value"]  # CSV header
    with open(log_file_path, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            match = data_re.search(line)
            if match:
                field = match.group(1).strip()
                value = match.group(2).strip()
                hex_value = match.group(3).strip()
                csv_lines.append(f"{field},{value},{hex_value}")

    # Write to CSV file
    with open(csv_file, 'w', encoding='utf-8') as f:
        f.write('\n'.join(csv_lines))

    print(f"CSV conversion completed! Total {len(csv_lines)-1} records extracted")
    print(f"CSV file saved to: {Path(csv_file).absolute()}")

# Example usage
if __name__ == "__main__":
    # ========== Universal Configuration ==========
    OUTPUT_FILE = "extracted_logs.log"
    CSV_FILE = "extracted_data.csv"
    CONFIG_FILE = "test_config_global.log"  # Configuration file for multiple extractions
    OUTPUT_DIR = "extracted_logs"  # Directory to save extracted files

    # 1. Example 1: Extract using configuration file (NEW FEATURE)
    try:
        # Create a temporary extractor with a dummy path (will be overridden by config)
        extractor = LogRangeExtractor("dummy.log")
        
        # Extract multiple ranges from config file
        extractor.extract_from_config(
            config_file=CONFIG_FILE,
            output_dir=OUTPUT_DIR,
            case_sensitive=False,
            include_boundaries=True
        )

    except Exception as e:
        print(f"Extraction error: {str(e)}")
        sys.exit(1)
    
    # 2. Example 2: Extract single range (original method)
    """
    try:
        extractor = LogRangeExtractor(LOG_FILE)
        
        # Extract from "Capture one transaction rcmd" to next non-UVM_INFO_EXT line
        # End pattern: Any line not starting with UVM_INFO (adjust as needed)
        extractor.extract_range(
            start_pattern=r"Capture one transaction rcmd",
            end_pattern=r"^(?!UVM_INFO).*",  # Regex: lines not starting with UVM_INFO
            output_file=OUTPUT_FILE,
            case_sensitive=False,
            include_boundaries=True,
            stop_after_first=False
        )

        # 3. Optional: Convert extracted logs to CSV (for structured data)
        extract_to_csv(OUTPUT_FILE, CSV_FILE)

        # 4. Optional: Real-time extraction (uncomment to use)
        # extractor.realtime_extract(
        #     start_pattern=r"Capture one transaction rcmd",
        #     end_pattern=r"^(?!UVM_INFO).*",
        #     case_sensitive=False
        # )

    except Exception as e:
        print(f"Extraction error: {str(e)}")
        sys.exit(1)
    """

# Example config file content (save as extract_config.txt):
"""
# Log extraction configuration
# Format: start:pattern
#         end:pattern

start:aaa
end:bbb

start:ccc
end:ddd

# You can add more ranges as needed
start:START_OF_SECTION
end:END_OF_SECTION
"""
