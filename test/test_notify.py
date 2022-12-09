import unittest
import os


class NotifyTestCase(unittest.TestCase):

    @classmethod
    def setUpClass(self):

        self.notifyto = os.environ['NOTIFYTO']
        self.propy = os.environ['PROPY']
        self.computername = os.environ['COMPUTERNAME']

    @classmethod
    def tearDownClass(self):

        pass

    def test_anotify(self):

        try:
            # refactor cluephone - system call 
            os.system('{0} notify.py {1} {2} {3}'.format(self.propy
                                                        ,'testing-email-from-' + self.computername   
                                                        ,self.notifyto
                                                        ,'test'))
        except:
            raise ValueError('notify.py call failed')

        pass

if __name__ == '__main__':
    unittest.main()