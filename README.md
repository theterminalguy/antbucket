<h1>Ant Bucket</h1>
<hr />
[![Coverage Status](https://coveralls.io/repos/github/andela-sdamian/ant-bucket/badge.svg?branch=master)](https://coveralls.io/github/andela-sdamian/ant-bucket?branch=master) [![Code Climate](https://codeclimate.com/github/andela-sdamian/ant-bucket/badges/gpa.svg)](https://codeclimate.com/github/andela-sdamian/ant-bucket) [![Build Status](https://travis-ci.org/andela-sdamian/ant-bucket.svg?branch=master)](https://travis-ci.org/andela-sdamian/ant-bucket)

<h3>Getting Started</h3>

Ant Bucket is an API that lets you manage a bucket list. A bucket list is simply a number of experiences or achievements that a person hopes to have or accomplish during their lifetime. With Ant Bucket, managing a bucket list is simply easy this is also good news for developers looking forward to integrating our API for all kinds of devices. Even existing apps can utilize this functionality as an add-on. Our API is currently hosted on <a href="https://antbucket.herokuapp.com">Heroku</a>. 


The best place to get started when using our API is to use our <a href="https://antbucket.herokuapp.com">API Documentation</a>. Our API documentation is highly and clearly written.
	
<h3>External Dependencies</h3>

All our dependencies can be found in our Gemfile. To see a list of all our dependencies, just open it up. However, Ant Bucket has no other dependencies aside from gems list in the Gemfile. Our API only returns JSON so just ensure you can parse JSON from your end and send a request to our server using standard HTTP verbs. 


<h3>Available End Points</h3>

<table>
<tr>
	<th>End Point</th>
	<th>Function</th>
</tr>

<tr>
  <td>POST /api/v1: </td>
  <td>Create a new user</td>
</tr>


<tr>
	<td>GET /auth/login: </td>
	<td>Logs a user in</td>
</tr>

<tr>
	<td>GET /auth/login: </td>
	<td>Logs a user in</td>
</tr>

<tr>
	<td>GET /auth/logout:</td>
	<td>Logs a user out</td>
</tr>

<tr>
	<td>POST /bucketlists:</td>
	<td>Creates a new bucket list</td>
</tr>

<tr>
	<td>GET /bucketlists:</td>
	<td>Lists all the created bucket lists</td>
</tr>

<tr>
	<td>GET /bucketlists/(id):</td>
	<td>Gets a single bucket list</td>
</tr>

<tr>
	<td>PUT /bucketlists/(id):</td>
	<td>Updates this single bucket list</td>
</tr>

<tr>
	<td>DELETE /bucketlists/(id):</td>
	<td>Deletes this single bucket list</td>
</tr>

<tr>
	<td>POST /bucketlists/(id)/items:</td>
	<td>Creates a new item in bucket list</td>
</tr>

<tr>
	<td>PUT /bucketlists/(id)/items/(item_id):</td>
	<td>Updates a bucket list item</td>
</tr>

<tr>
	<td>DELETE /bucketlists/(id)/items/(item_id):</td>
	<td>Deletes an item in a bucket list</td>
</tr>

</table>

<h3>Typical Data Model</h3>

A typical bucket list requested by a user could look like this:
<pre>
	{
    id: 1,
    name: “My Bucket List”,
    items: [
           {
               id: 1,
               name: “I need to do settle down”,
               date_created: “2095-08-12 11:57:23”,
               date_modified: “2095-08-12 12:00:00”,
               done: false
             }
           ]
    date_created: “2015-08-12 11:00:00”,
    date_modified: “2015-08-12 12:00:00”
    created_by: “John”
}
</pre>

<h3>End-Point Publicity</h3>
Some end points are not available public and here they are listed below

<table>
<tr>
	<th>End Point</th>
	<th>Publicity</th>
</tr>

<tr>
	<td>GET /auth/login: </td>
	<td>TRUE</td>
</tr>

<tr>
	<td>GET /auth/login: </td>
	<td>FALSE</td>
</tr>

<tr>
	<td>GET /auth/logout:</td>
	<td>FALSE</td>
</tr>

<tr>
	<td>POST /bucketlists:</td>
	<td>FALSE</td>
</tr>

<tr>
	<td>GET /bucketlists:</td>
	<td>FALSE</td>
</tr>

<tr>
	<td>GET /bucketlists/(id):</td>
	<td>FALSE</td>
</tr>

<tr>
	<td>PUT /bucketlists/(id):</td>
	<td>FALSE</td>
</tr>

<tr>
	<td>DELETE /bucketlists/(id):</td>
	<td>FALSE</td>
</tr>

<tr>
	<td>POST /bucketlists/(id)/items:</td>
	<td>FALSE</td>
</tr>

<tr>
	<td>PUT /bucketlists/(id)/items/(item_id):</td>
	<td>FALSE</td>
</tr>

<tr>
	<td>DELETE /bucketlists/(id)/items/(item_id):</td>
	<td>FALSE</td>
</tr>

</table>


<h3> Pagination </h3>
Ant Bucket comes with pagination by default, so you can specify the number of results you would like to return via a <code>GET</code> request  using the <code>limit</code> keyword. 

<h4>Example</h4>
<b>Request:</b>
<pre>
GET https://antbucket.herokuapp.com/api/v1/bucketlists?page=2&limit=20
</pre>

<b>Response:</b>
<pre>
20 bucket list records belonging to the logged in user starting from the 21st gets returned. 
</pre>

<b>Searching by Name</b>

  Users can search for bucket list by its name using a <code>GET</code>request <code>q</code>.

<b>Example</b>

<b>Request:</b>
 <pre>
  GET https://antbucket.herokuapp.com/api/v1/bucketlists?q="my bucket list"
 </pre>

<b>Response:</b>

  Bucket lists with title “my bucket list” gets returned


<h3> Versions</h3>

This API has only one version for now, and it can be accessed via -<a href="https://antbucket.herokuapp.com/api/v1/endpoint">https://antbucket.herokuapp.com/api/v1/endpoint</a>


<h3>Running Test</h3>
Since Ant Bucket is built with rails, you would expect we use the default rails mini test, however, we skipped that to use RSpec. Running our test suite is simply easy. To run the entire test suite, use the usual: 

<code>bundle exec rspec</code>	


<h3>Limitations</h3>
Currently, we can't say our API can handle larger requests, this may be a problem when our user base grows to over million. However, when that time comes, we would be by your side.


<h3>Contributing</h3>

Bug reports and pull requests are welcome on GitHub. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the <a href="http://todogroup.org/opencodeofconduct/">Contributor Covenant code of conduct</a>.

<h3>License</h3>

This app is available as open source under the terms of the <a href="http://www.gnu.org/licenses/gpl-3.0.en.html">GNU Public License</a>
