# To add a new cell, type '# %%'
# To add a new markdown cell, type '# %% [markdown]'
# %%
import re
import subprocess
from getpass import getpass
from json import loads
from os import environ
from pathlib import Path

from github import Github, InputFileContent
from keyring import get_password

#%% [markdown]
"""
Dela upp i två .py
En för att försäkra bitwarden-auth
En för gist-processing
Importera bitwarden-auth i gist-processing
! Gör GUI-prompt om inloggning behövs?
! Nä förlita inte på bw/keyring främst. Testa tokens i secrets först, om de inte funkar fixa nya.
? Lazy imports

argparse!
Gör en code/bin och/eller symlink från executables till en PATH-path
För symlinks: gör symlinken utan .py-extension!


Log in vs unlock.

try - catch där det kan komma exceptions.

try:
    get_session_id()

catch:
    generate_session_id()

! Går det att göra tester? (npm test)
TODO static typechecking pypy
pypy i vscode? linting?
"""

#%%

home_dir = str(Path.home())
secrets_file = home_dir + '/.secrets'

def get_secrets_session_id():

    with open(secrets_file, mode='r') as f:
        secrets_content = (i.strip() for i in f.readlines())

    pattern = re.compile('(?:^export BW_SESSION=")(.{88})')

    if any((match := pattern.match(i)) for i in secrets_content):
        return match.group(1)
    else:
        raise Exception('Session ID not found in ~/.secrets.')


def generate_session_id():
    while True:
        print('Unlock Bitwarden to generate new Session ID.')

        bw_pass = getpass(prompt='Bitwarden master password: ')
        if not bw_pass:
            raise Exception('No password entered, exiting.')

        unlock = ['bw', 'unlock', bw_pass]
        # ! --raw ger koden rätt av!
        bw_output = subprocess.run(unlock, stdout=subprocess.PIPE)

        if bw_output.returncode:
            print('Incorrect password, try again.')
            continue

        bw_stdout = bw_output.stdout.decode()
        result_list = list(filter(None, bw_stdout.splitlines()))

        pattern = re.compile('(?:\$ export BW_SESSION=")(.{88})')
        if any((match := pattern.match(i)) for i in result_list):
            session_id = match.group(1)
            return session_id
        else:
            raise Exception('Could not generate Session ID, exiting.')

def bw_is_unlocked():
    bw_status = ['bw', 'status']
    bw_output = subprocess.run(bw_status, stdout=subprocess.PIPE).stdout.decode()

    pattern = re.compile('(?:.*\\n)?(.*)') # TODO Kolla om denna behöver dubbel backslash
    json = pattern.match(bw_output).group(1)
    is_unlocked = loads(json)['status'] == 'unlocked'

    return is_unlocked

def set_secrets_session_id(session_id):
    with open(secrets_file, mode='r') as f:
        content = f.read()

    pattern = re.compile('export BW_SESSION=".*"(\n)?')
    new_content = pattern.sub('', content) # Delete old session if existent
    new_content = re.sub('\n$', '\n', new_content) # Assure separated lines
    new_content += f'export BW_SESSION="{session_id}"\n' # Append new session

    with open(secrets_file, mode='w') as f:
        f.write(new_content)

    return


#%%

# Se till så att BW_SESSION finns
try:
    environ['BW_SESSION']

except KeyError:
    try:
        session_id = get_secrets_session_id()

    except (FileNotFoundError, Exception) as e:
        print(e)
        session_id = generate_session_id()
        set_secrets_session_id(session_id)

    environ['BW_SESSION'] = session_id

# Se till så att BW_SESSION funkar
# assert(bw_is_unlocked()), 'Bitwarden is locked'
if bw_is_unlocked():
    print('Unlocked!')
else:
    print('Locked.')
    # print('Invalid session ID: log in to Bitwarden to generate new session.')


# %%
try:
    token = get_password('gist.github.com', 'gist')
    if not token: raise Exception

except ValueError:
    print('Authentication failed. Add "export BW_SESSION=[session id]" to ~/.secrets file.')  # Gör generell? Inte bara BW
except Exception as e:
    print(e)
    print('Token not found.')

else:
    g = Github(token)
    g_auth_user = g.get_user()
    gists = g_auth_user.get_gists()


# %%
hostname = os.uname().nodename
pacman_file_name = hostname + '.pacman-list.pkg'
pacman_file_path = '/tmp/' + pacman_file_name
aur_file_path = '/tmp/' + aur_file_name
aur_file_name = hostname + '.aur-list.pkg'

os.system('pacman -Qqen > ' + pacman_file_path)
os.system('pacman -Qqem > ' + aur_file_path)

with open(pacman_file_path, 'r') as f:
    pacman_file_content = f.read()

with open(aur_file_path, 'r') as f:
    aur_file_content = f.read()


# %%
'''
Om token inte finns, ge error
Om hostname-gist-id finns: uppdatera den, annars skapa ny.

"python.envFile": "${workspaceFolder}/.env"
'''


# %%
def read_gist(gist_id):
    '''
    gist = g.get_gist(gist_id)
    gist_file, *_ = gist.files.values()
    gist_content = gist_file.content
    '''
    pass

def create_gist(filename, content, description):
    return g_auth_user.create_gist(
        public = False,
        files = { filename: InputFileContent(content=content) },
        description = description
    )

def edit_gist(gist_id, content):
    gist = g.get_gist(gist_id)
    gist_filename = next(iter(gist.files.values())).filename

    return gist.edit(
        files = { gist_filename: InputFileContent(content=content) }
    )

def gist_list():
    for gist in gists:
        public = '+' if gist.public else '-'
        print(f'{gist.id} {public} {gist.description}')


# %%
gist_list()
