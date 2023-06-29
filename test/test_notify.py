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
            # sends an email as a test. come on now
            # we are merely testing that we don't error 
            # and demonstrating usages. better than nothing i guess
            os.system('{0} notify.py {1} {2} {3}'.format(self.propy
                                                        ,'testing-email-from-' + self.computername   
                                                        ,self.notifyto
                                                        ,'test'))
        except:
            raise ValueError('notify.py call failed')

        pass

    def test_bnotifycheck(self):

        #check the log for caminante and notify 

        try:
            os.system('{0} notify.py {1} {2} {3} {4}'.format(self.propy
                                                            ,'testing-email-from-' + self.computername   
                                                            ,self.notifyto
                                                            ,'test'
                                                            ,'caminante'))
        except:
            raise ValueError('notify.py call failed')

        pass

    def test_cnonotifycheck(self):

        # check the log for a word that is not there
        # should not notify but you must test with eyeballs

        try:
            os.system('{0} notify.py {1} {2} {3} {4}'.format(self.propy
                                                            ,'testing-email-from-' + self.computername   
                                                            ,self.notifyto
                                                            ,'test'
                                                            ,'antoniomachado'))
        except:
            raise ValueError('notify.py call failed')

        pass

if __name__ == '__main__':
    unittest.main()