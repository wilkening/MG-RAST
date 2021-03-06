"""A basic Shock (https://github.com/MG-RAST/Shock) python access class.

Authors:

* Jared Wilkening
* Travis Harrison
"""

#-----------------------------------------------------------------------------
# Imports
#-----------------------------------------------------------------------------

import cStringIO
import os
import requests
import urllib
from requests_toolbelt import MultipartEncoder

#-----------------------------------------------------------------------------
# Classes
#-----------------------------------------------------------------------------

class ShockClient:
    
    shock_url = ''
    auth_header = {}
    token = ''
    bearer = ''
    template = "An exception of type {0} occured. Arguments:\n{1!r}"
    methods = { 'get': requests.get,
                'put': requests.put,
                'post': requests.post,
                'delete': requests.delete }
    
    def __init__(self, shock_url='http://shock.mg-rast.org', bearer='OAuth', token=None):
        self.shock_url = shock_url
        if token:
            self.set_auth(bearer, token)
        
    def set_auth(self, bearer, token):
        self.auth_header = {'Authorization': bearer+' '+token}
    
    def get_acl(self, node):
        return self._manage_acl(node, 'get')
    
    def add_acl(self, node, acl, user=None, public=False):
        return self._manage_acl(node, 'put', acl, user, public)
    
    def delete_acl(self, node, acl, user=None, public=False):
        return self._manage_acl(node, 'delete', acl, user, public)
    
    def _manage_acl(self, node, method, acl=None, user=None, public=False):
        url = self.shock_url+'/node/'+node+'/acl'
        if acl and user:
            url += '/'+acl+'?users='+urllib.quote(user)
        elif acl and public:
            url += '/public_'+acl
        try:
            req = self.methods[method](url, headers=self.auth_header)
        except Exception as ex:
            message = self.template.format(type(ex).__name__, ex.args)
            raise Exception(u'Unable to connect to Shock server %s\n%s' %(url, message))
        if not (req.ok and req.text):
            raise Exception(u'Unable to connect to Shock server %s: %s' %(url, req.raise_for_status()))
        rj = req.json()
        if not (rj and isinstance(rj, dict) and all([key in rj for key in ['status','data','error']])):
            raise Exception(u'Return data not valid Shock format')
        if rj['error']:
            raise Exception('Shock error %s: %s'%(rj['status'], rj['error'][0]))
        return rj['data']
    
    def update_expiration(self, node, expiration=None):
        url = self.shock_url+'/node/'+node
        if expiration:
            edata = {'expiration': expiration}
        else:
            edata = {'remove_expiration': "true"}
        mdata = MultipartEncoder(fields=edata)
        headers = self.auth_header.copy()
        headers['Content-Type'] = mdata.content_type
        try:
            req = self.methods['put'](url, headers=headers, data=mdata, allow_redirects=True)
            rj  = req.json()
        except Exception as ex:
            message = self.template.format(type(ex).__name__, ex.args)
            raise Exception(u'Unable to connect to Shock server %s\n%s' %(url, message))
        if rj['error']:
            raise Exception(u'Shock error %s: %s'%(rj['status'], rj['error'][0]))
        return rj['data']
        
    def get_node(self, node):
        return self._get_node_data('/'+node)
    
    def query_node(self, query):
        query_string = '?query&'+urllib.urlencode(query)
        return self._get_node_data(query_string)
    
    def _get_node_data(self, path):
        url = self.shock_url+'/node'+path
        try:
            rget = self.methods['get'](url, headers=self.auth_header)
        except Exception as ex:
            message = self.template.format(type(ex).__name__, ex.args)
            raise Exception(u'Unable to connect to Shock server %s\n%s' %(url, message))
        if not (rget.ok and rget.text):
            raise Exception(u'Unable to connect to Shock server %s: %s' %(url, rget.raise_for_status()))
        rj = rget.json()
        if not (rj and isinstance(rj, dict) and all([key in rj for key in ['status','data','error']])):
            raise Exception(u'Return data not valid Shock format')
        if rj['error']:
            raise Exception('Shock error %s: %s'%(rj['status'], rj['error'][0]))
        return rj['data']
    
    def download_to_string(self, node, index=None, part=None, chunk=None, binary=False):
        result = self._get_node_download(node, index=index, part=part, chunk=chunk, stream=False)
        if binary:
            return result.content
        else:
            return result.text
    
    def download_to_path(self, node, path, index=None, part=None, chunk=None):
        if path == '':
            raise Exception(u'download_to_path requires non-empty path parameter')
        result = self._get_node_download(node, index=index, part=part, chunk=chunk, stream=True)
        with open(path, 'wb') as f:
            for chunk in result.iter_content(chunk_size=8192): 
                if chunk:
                    f.write(chunk)
                    f.flush()
        return path
    
    def _get_node_download(self, node, index=None, part=None, chunk=None, stream=False):
        if node == '':
            raise Exception(u'download requires non-empty node parameter')
        url = '%s/node/%s?download'%(self.shock_url, node)
        if index and part:
            url += '&index='+index+'&part='+str(part)
            if chunk:
                url += '&chunk_size='+str(chunk)
        try:
            rget = self.methods['get'](url, headers=self.auth_header, stream=stream)
        except Exception as ex:
            message = self.template.format(type(ex).__name__, ex.args)
            raise Exception(u'Unable to connect to Shock server %s\n%s' %(url, message))
        if not (rget.ok):
            raise Exception(u'Unable to connect to Shock server %s: %s' %(url, rget.raise_for_status()))
        return rget
    
    def delete_node(self, node):
        url = self.shock_url+'/node/'+node
        try:
            req = self.methods['delete'](url, headers=self.auth_header)
            rj  = req.json()
        except Exception as ex:
            message = self.template.format(type(ex).__name__, ex.args)
            raise Exception(u'Unable to connect to Shock server %s\n%s' %(url, message))
        if rj['error']:
            raise Exception(u'Shock error %s: %s (%s)'%(rj['status'], rj['error'][0], node))
        return rj
    
    def index_node(self, node, index, column=None, force=False):
        url = "%s/node/%s/index/%s"%(self.shock_url, node, index)
        params = {}
        if column is not None:
            params['number'] = str(column)
        if force:
            params['force_rebuild'] = 1
        try:
            if params:
                url += '?'+urllib.urlencode(params)
            req = self.methods['put'](url, headers=self.auth_header)
            rj  = req.json()
        except Exception as ex:
            message = self.template.format(type(ex).__name__, ex.args)
            raise Exception(u'Unable to connect to Shock server %s\n%s' %(url, message))
        if rj['error']:
            raise Exception(u'Shock error %s: %s (%s)'%(rj['status'], rj['error'][0], node))
        return rj
    
    def index_subset(self, node, name, parent, subset_file):
        url = "%s/node/%s/index/subset"%(self.shock_url, node)
        pdata = {'index_name': name, 'parent_index': parent, 'subset_indices': self._get_handle(subset_file)}
        mdata = MultipartEncoder(fields=pdata)
        headers = self.auth_header.copy()
        headers['Content-Type'] = mdata.content_type
        try:
            req = self.methods['put'](url, headers=headers, data=mdata, allow_redirects=True)
            rj  = req.json()
        except Exception as ex:
            message = self.template.format(type(ex).__name__, ex.args)
            raise Exception(u'Unable to connect to Shock server %s\n%s' %(url, message))
        if rj['error']:
            raise Exception(u'Shock error %s: %s (%s)'%(rj['status'], rj['error'][0], node))
        return rj        
    
    def copy_node(self, parent_node, attr='', copy_index=True):
        url = self.shock_url+'/node'
        pdata = {'copy_data': parent_node}
        if attr != '':
            pdata['attributes'] = self._get_handle(attr)
        if copy_index:
            pdata['copy_indexes'] = 'true'
        mdata = MultipartEncoder(fields=pdata)
        headers = self.auth_header.copy()
        headers['Content-Type'] = mdata.content_type
        try:
            req = self.methods['post'](url, headers=headers, data=mdata, allow_redirects=True)
            rj  = req.json()
        except Exception as ex:
            message = self.template.format(type(ex).__name__, ex.args)
            raise Exception(u'Unable to connect to Shock server %s\n%s' %(url, message))
        if rj['error']:
            raise Exception(u'Shock error %s: %s'%(rj['status'], rj['error'][0]))
        return rj['data']
    
    def create_node(self, data='', attr='', data_name=''):
        return self.upload("", data, attr, data_name)
    
    # file_name is name of data file
    # form == True for multi-part form
    # form == False for data POST of file
    def upload(self, node='', data='', attr='', file_name='', form=True):
        method = 'post'
        files = {}
        url = self.shock_url+'/node'
        if node != '':
            url = '%s/%s'%(url, node)
            method = 'put'
        if data != '':
            files['upload'] = self._get_handle(data, file_name)
        if attr != '':
            files['attributes'] = self._get_handle(attr)
        if form:
            mdata = MultipartEncoder(fields=files)
            headers = self.auth_header.copy()
            headers['Content-Type'] = mdata.content_type
            try:
                req = self.methods[method](url, headers=headers, data=mdata, allow_redirects=True)
                rj  = req.json()
            except Exception as ex:
                message = self.template.format(type(ex).__name__, ex.args)
                raise Exception(u'Unable to connect to Shock server %s\n%s' %(url, message))
        elif (not form) and data:
            try:
                req = self.methods[method](url, headers=self.auth_header, data=files['upload'][1], allow_redirects=True)
                rj  = req.json()
            except Exception as ex:
                message = self.template.format(type(ex).__name__, ex.args)
                raise Exception(u'Unable to connect to Shock server %s\n%s' %(url, message))
        else:
            raise Exception(u'No data specificed for %s body'%method)
        if not (req.ok):
            raise Exception(u'Unable to connect to Shock server %s: %s' %(url, req.raise_for_status()))
        if rj['error']:
            raise Exception(u'Shock error %s: %s%s'%(rj['status'], rj['error'][0], ' ('+node+')' if node else ''))
        return rj['data']
    
    # handles 3 cases
    # 1. file path
    # 2. file object (handle)
    # 3. file content (string)
    def _get_handle(self, d, n=''):
        try:
            if os.path.exists(d):
                name = n if n else os.path.basename(d)
                return (name, open(d))            
            else:
                name = n if n else "unknown"
                return (name, cStringIO.StringIO(d))
        except TypeError:
            try:
                name = n if n else "unknown"
                return (name, d)
            except:
                raise Exception(u'Error opening file handle for upload')
