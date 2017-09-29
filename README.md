# Library API

The library API is hosted on Heroku, and the requests detailed in the docs below can be sent to [https://headspace-library-api.herokuapp.com/](https://headspace-library-api.herokuapp.com/).

## Setup

Pull down the source. To download dependencies, run:
```
$ bundle install
```
To start the server, run:
```
$ bin/rails s
```
To run tests, run:
```
$ bin/rspec
```
To run the linter, run:
```
$ bin/rubocop
```

# API

## Users

### Create a User [POST]

Create a user with a username. Username must be unique.

**Request (application/json)**

_Path_

`/api/v1/users`

_Params_

- `username`: String representing username.

_Body_

```
    {
        "username": "batman"
    }
```

**Response 201 (application/json)**

_Params_

- `id`: Primary key of user record.
- `username`:  String representation of username.
- `created_at`: Timestamp of creation.
-  `updated_at`: Timestamp of last update.

_Body_

```
{
    "id": 1,
    "username": "batman",
    "created_at": "2017-09-29T11:46:39.959Z",
    "updated_at": "2017-09-29T11:46:39.959Z"
}
```


## Books

### Create a Book [POST]

Create a book with a title and an author.

**Request (application/json)**

_Path_

`/api/v1/books`

_Params_

- `title`: String, title of book.
- `author`: String, author of book.

_Body_

```
{
    "title": "Clean Code",
    "author": "Unclde Bob"
}
```


**Response 201 (application/json)**

_Fields_

- `id`: Primary key of book record.
- `author`: Author of book.
- `title`: Title of book.
- `created_at`: Timestamp of creation.
- `updated_at`: Timestamp of last update.

_Body_

```
    {
        "id": 1,
        "author": "Uncle Bob",
        "title": "Clean Code",
        "created_at": "2017-09-29T12:43:32.887Z",
        "updated_at": "2017-09-29T12:43:32.887Z"
    }
```

## UserBooks

UserBooks are a join table between Users and Books, and associates a User record with a Book record. A User can have many UserBooks and a Book can have many UserBooks.

### Create a UserBook [POST]

Creates a UserBook using a User ID and a Book ID. By default, the `read` field is `false` when a UserBook is created.

**Request (application/json)**

_Path_

`/api/v1/users/:user_id/user_books`

_Params_

    - `book_id`: Primary key of book record.

_Body_

```
    {
        "book_id": 1
    }
```


**Response 201 (application/json)**

_Fields_

- `id`: Primary key of UserBook record.
- `read`: Boolean representing if user has read book or not.
- `user`: Object with user fields. See User section.
- `book`: Object with book fields. See Book section.

_Body_

```
    {
        "id": 1,
        "read": false,
        "user": {
            "id": 1,
            "username": "batman",
            "created_at": "2017-09-29T11:46:39.959Z",
            "updated_at": "2017-09-29T11:46:39.959Z"
        },
        "book": {
            "id": 1,
            "author": "Uncle Bob",
            "title": "Clean Code",
            "created_at": "2017-09-29T12:43:32.887Z",
            "updated_at": "2017-09-29T12:43:32.887Z"
        }
    }
```


### Get a list of UserBooks [GET]

Returns list of UserBooks for User. Optionally pass query parameters to filter list of UserBooks by read status or book author.

**Request (application/json)**

_Path_

`/api/v1/users/:user_id/user_books`

_Query Params_

- `author`: (optional) author of the book.
- `read` : (optional) boolean value for read status.


**Response**

_Feilds_

- `id`: Primary key of UserBook record.
- `read`: Boolean read status of UserBook.
- `user`: Object with user fields. See User section.
- `book`: Object with book fields. See Book section.

_Body_

```
    {
        "data": [
            {
                "id": 1,
                "read": false,
                "user": { ... },
                "book": { ... }
            }
        ],
        "page": 1,
        "per_page": 10,
        "total_pages": 1,
        "total_count": 1
    }
```


### Update a UserBook [PUT]

Updates a UserBook's `read` field.


**Request**

_Path_

`/api/v1/users/:user_id/user_books/:id`

_Params_

- `read`: Boolean value for read status.

_Body_

```
{
    "read": true
}
```


**Response**

_Fields_

- `id`: Primary key of UserBook.
- `read`: Boolean value for read status.
- `user`: Object with User fields. See User section.
- `book`: Object with Book fields. See Book section.

_Body_

```
{
    "id": 1,
    "read": true,
    "user": { ... },
    "book": { ... }
}
```

### Delete a UserBook [DELETE]

**Request (application/json)**

_Path_

`/api/v1/uses/:user_id/user_books/:id`

**Reponse 200**

Empty 200 OK response.
