def colored(t, c):
    return f"\033[{c}m{t}\033[0m"

def print_summary(all_pass_num, all_fail_num, all_warning_num, all_timeout_num):
    all_tc = all_pass_num + all_fail_num + all_warning_num + all_timeout_num
    if all_tc == 0: all_tc = 1

    pass_pct    = round(all_pass_num / all_tc * 100, 1)
    fail_pct    = round(all_fail_num / all_tc * 100, 1)
    warn_pct    = round(all_warning_num / all_tc * 100, 1)
    timeout_pct = round(all_timeout_num / all_tc * 100, 1)

    bar = "=" * 95
    mid_bar = "-" * 95

    print(bar)
    print(colored("                     ✅ Regression Summary Report ✅".center(95), "1;37"))
    print(mid_bar)
    print(f"{colored('PASS    :', '1;32')} {str(all_pass_num).rjust(5)}  ({pass_pct:>5} %)")
    print(f"{colored('FAIL    :', '1;31')} {str(all_fail_num).rjust(5)}  ({fail_pct:>5} %)")
    print(f"{colored('WARNING :', '1;33')} {str(all_warning_num).rjust(5)}  ({warn_pct:>5} %)")
    print(f"{colored('TIMEOUT :', '1;36')} {str(all_timeout_num).rjust(5)}  ({timeout_pct:>5} %)")
    print(mid_bar)
    print(f"Total Testcases : {all_tc}".center(95))
    print(bar)


# Test Example
print_summary(120, 15, 3, 2)
