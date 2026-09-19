from .common import *


class CliTests(unittest.TestCase):
    limit_line = LIMIT_LINE
    server = staticmethod(make_server)

    def test_command_limit_is_auto_when_omitted_and_explicit_when_supplied(self):
        parser = bench.build_parser()
        self.assertIsNone(parser.parse_args(['run', 'ability_rays']).command_limit)
        self.assertIsNone(parser.parse_args(['suite', 'all_abilities']).command_limit)
        self.assertEqual(parser.parse_args(['run', 'ability_rays', '--command-limit', '1000000']).command_limit, 1000000)
        self.assertEqual(parser.parse_args(['suite', 'all_abilities', '--command-limit', '1000000']).command_limit, 1000000)
        for value in ['0', '-1', '2147483648']:
            with self.assertRaises(bench.argparse.ArgumentTypeError):
                bench.command_limit_argument(value)
