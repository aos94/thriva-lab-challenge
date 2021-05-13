# NOTES

## Areas of improvement

- When loading relationships in `SerializedItem#serialize_relationships`, the relationship models are queried and serialized in a loop. For models backed by a database, this would lead to N+1 queries (round-trips to the database), which can adversely affect response time to the API endpoints. To fix this, the relationships can be loaded beforehand (e.g leveraging a single JOIN query) and `SerializedItem` can then be modified to accept a collection of relations.

- For composing responses, the ResponseItem class can currently only handle responses for requests about a single item (i.e `Resource#show` endpoints). To handle collection responses (e.g requests to a `Resource#index` endpoint), a corresponding `ResponseCollection` class can be added to `app/response`.

- Response errors are currently handled as part of the `ResponseRendering` concern. For more flexibility around error handling, custom error response classes can be introduced to cater for various classes of errors.

- The examples in the request specs make assertions against the response's content_type, HTTP code and the JSON body. To reduce duplication across examples, a custom HTTP response RSpec matcher can be introduced that takes the expected response fixture as input and matches against the received response.

- The Rubocop gem can also be introduced as a linter to standardise the coding style.
