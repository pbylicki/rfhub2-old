from rfhub.kwdb import KeywordTable
from os.path import dirname, join
import unittest


class KeywordTableTest(unittest.TestCase):

    def setUp(self):
        self.kwdb = KeywordTable('sqlite:///:memory:')
        data_dir = join(dirname(__file__), 'data')
        self.one_keyword_resource = join(data_dir, 'onekeyword.robot')
        self.two_keywords_resource = join(data_dir, 'twokeywords.robot')

    def test_table_should_be_empty_after_init(self):
        self.assertLen(self.kwdb.get_keywords(), 0)

    def test_should_add_resource_file(self):
        self.kwdb.add(self.one_keyword_resource)
        self.assertLen(self.kwdb.get_keywords(), 1)

    def test_should_add_multiple_resource_files(self):
        self.kwdb.add(self.one_keyword_resource)
        self.kwdb.add(self.two_keywords_resource)
        self.assertLen(self.kwdb.get_keywords(), 3)

    def test_should_list_added_resources_as_collections(self):
        self.kwdb.add(self.one_keyword_resource)
        self.kwdb.add(self.two_keywords_resource)
        collections = self.kwdb.get_collections()
        self.assertLen(collections, 2)
        self.assertEqual(collections[0]['name'], 'onekeyword')
        self.assertEqual(collections[1]['name'], 'twokeywords')

    def test_should_list_keywords_with_library_names(self):
        self.kwdb.add(self.two_keywords_resource)
        keywords = self.kwdb.get_keywords()
        self.assertLen(keywords, 2)
        self.assertEqual(keywords[0][1], 'twokeywords')
        self.assertEqual(keywords[1][1], 'twokeywords')

    def test_should_list_keywords_with_names(self):
        self.kwdb.add(self.two_keywords_resource)
        keywords = self.kwdb.get_keywords()
        self.assertLen(keywords, 2)
        self.assertEqualAsSets([kw[2] for kw in keywords], ('Keyword #1', 'Keyword #2'))

    def test_should_list_keywords_with_documentation(self):
        self.kwdb.add(self.two_keywords_resource)
        keywords = self.kwdb.get_keywords()
        self.assertLen(keywords, 2)
        self.assertEqualAsSets([kw[3] for kw in keywords],
                               ('Documentation for Keyword #1', 'Documentation for Keyword #2'))

    def test_should_get_keyword_by_name_and_collection_id(self):
        self.kwdb.add(self.two_keywords_resource)
        for name in ('Keyword #1', 'Keyword #2'):
            keyword = self.kwdb.get_keyword(1, name)
            self.assertDictEqual(keyword,
                                 {'name': name, 'args': [], 'doc': f'Documentation for {name}', 'collection_id': 1})

    def assertLen(self, collection, size):
        self.assertEqual(len(collection), size)

    def assertEqualAsSets(self, first, second):
        self.assertSetEqual(set(first), set(second))
