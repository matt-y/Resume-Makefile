import traceback
import sys
import json
import chevron

def render_template(template_file, json_data):
    return chevron.render(template_file, json_data)

def main(argv):
    mustache_template = argv[0]
    json_data_file = argv[1]

    try:
        with open(mustache_template, 'r') as template_file, open(json_data_file, 'r') as json_file:
            json_data = json.load(json_file)
            rendered_template = render_template(template_file, json_data)

            print(rendered_template, file=sys.stdout)

    except Exception as e:
        print('Unable to render template', mustache_template, 'using', json_data_file, file=sys.stderr)
        print(e, file=sys.stderr)
        sys.exit(1)

if __name__ == '__main__':
    main(sys.argv[1:])
