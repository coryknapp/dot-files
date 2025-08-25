from re import sub
import sys
import clipboard
import re
import inspect

def get_clipboard():
    return clipboard.paste()

def set_clipboard(s):
    clipboard.copy(s)

def camel_case(s):
  """
  c:  camelCase
  """
  s = sub(r"(_|-)+", " ", s).title().replace(" ", "")
  return ''.join([s[0].lower(), s[1:]])

def Camel_case(s):
  """
  C:  CamelCase
  """
  s = camel_case(s)
  return s[0].upper() + s[1:]

def git_branch(s):
  """
  suggest a git branch name
  """
  s = standup_summery(s)
  s = re.sub(r'[^a-zA-Z0-9._-]', '-', s)
  s = re.sub(r'-+', '-', s)
  s = s.strip('-')
  return f"AB#{s}"

def standup_summery(s):
  """
  Standup summery template based on text copied from ADO
  """
  # split into lines
  s = s.split("\n")
  result = ""

  s = s[1:]
  for line in s:
    cells = line.split('\t')
    if len(cells) > 1:
      result = result + cells[0] + '\t' + cells[1] + '\n'
  return result

def sql_insert(s):
  """
  sql_insert?  NOt sure what this does
  """
  s = s.split("\n")
  result = ""
  for line in s:
    cells = line.split('\t')
    if len(cells) > 1:
      result = result + cells[0] + '\t' + cells[1] + '\n'
  return result

def slash_dot(s):
    """
    replace slash with dot
    """
    return s.replace('/', '.')

def dot_slash(s):
    """
    replace dot with slash
    """
    return s.replace('.', '/')

def current_git_branch(s):
    """
    copy current git branch
    """
    return subprocess.check_output(['git', 'branch', '--show-current'], text=True).strip()

def strip_quotes(s):
    """
    strip quotes
    """
    return s.replace('"', '')

def print_help():
    """
    print this message
    """
    for item in command_handlers:
        print(item, ":", inspect.getdoc(command_handlers[item]))
        
    

    
def print_in_color(text, color_code):
    print(f"\033[{color_code}m{text}\033[0m")
    
command_handlers = {
    'h': print_help,
    'c': camel_case,
    'C': Camel_case,
    'su': standup_summery,
    'bn': git_branch,
    '/.': slash_dot,
    './': dot_slash,
    'cb': current_git_branch,
    'sq': strip_quotes,
}

if __name__ == "__main__":

    sys.argv.append("h")
    command = sys.argv[1]
    
    if command == "h":
        print_help()
        sys.exit()
        
    cb = get_clipboard()
    print_in_color(cb, "31")

    cb = command_handlers[command](cb)

    print()
    print_in_color(cb, "32")
    set_clipboard(cb)
    