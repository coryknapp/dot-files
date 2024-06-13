from re import sub
import sys
import clipboard

def get_clipboard():
    return clipboard.paste()

def set_clipboard(s):
    clipboard.copy(s)

def camel_case(s):
  s = sub(r"(_|-)+", " ", s).title().replace(" ", "")
  return ''.join([s[0].lower(), s[1:]])

def Camel_case(s):
  s = camel_case(s)
  return s[0].upper() + s[1:]

def git_branch(s):
  s = s.replace(" ", "_").replace("_-_", "-").replace("\t", "-")
  return s

def csharp_class_members_to_init(s, construct_nonprimitive_members, ):
  # split into lines
  s = s.split("\n")
  result = ""

  for line in s:
    split_line = line.split()

    if len(split_line) == 0:
       continue

    protection_offset = 0
    if split_line[0] in {'public', 'private'}:
      protection_offset = 1

    memberType = split_line[protection_offset]
    memberName = split_line[protection_offset+1]

    if memberType in {"sbyte", "byte", "short", "ushort", "int", "uint", "long", "ulong"}:
       memberValue = "0"
    elif memberType == "bool":
       memberValue = "false"
    elif memberType == "char":
      memberValue = "'x'"
    elif memberType == "string":
       memberValue = '"' + memberName + '"'
    elif memberType == "Guid":
       memberValue = "Guid.NewGuid()"
    elif construct_nonprimitive_members == True:
       memberValue = memberType + "()" 
    else:
      memberValue = "null"
    result = result + memberName + " = " + memberValue + ",\n"

  return result

def standup_summery(s):
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
  s = s.split("\n")
  result = ""
  for line in s:
    cells = line.split('\t')
    if len(cells) > 1:
      result = result + cells[0] + '\t' + cells[1] + '\n'
  return result

def slash_dot(s):
   return s.replace('/', '.')

def dot_slash(s):
   return s.replace('.', '/')

if __name__ == "__main__":
    cb = get_clipboard()
    print(cb)

    sys.argv.append('su')

    if sys.argv[1] == 'c':
        cb = camel_case(cb)
    if sys.argv[1] == 'C':
        cb = Camel_case(cb)
    if sys.argv[1] == 'g':
        cb = git_branch(cb)
    if sys.argv[1] == 'c#m':
        cb = csharp_class_members_to_init(cb, True)
    if sys.argv[1] == 'su': #standup update
        cb = standup_summery(cb)
    if sys.argv[1] == 'bn': #branch name
        cb = git_branch(standup_summery(cb))
    if sys.argv[1] == '/.': #branch name
        cb = slash_dot(cb)
    if sys.argv[1] == './': #branch name
        cb = dot_slash(cb)

    print()
    print(cb)
    set_clipboard(cb)