# Milestone Recorder

## Building the app

The app is build using the [Haskell Tool Stack](https://docs.haskellstack.org/en/stable/README/).

To build the app, run `stack build`.

## Running the app

The app can be run through stack by executing `stack run`.

Commands are specified after `run`, and are case-insensitive.

### Adding milestones
To add a milestone:
```
~ : stack run add 2021-01-02 "Test entry"
Added 2021-01-02 Test entry
```

### Listing milestones
To list milestones:
```
~ : stack run list
1: 2021-1-2 - Test entry
2: 2021-2-23 - Another entry
```

```list``` can take optional parameters to return dates in a range:
- `stack run list after YYYY-MM-DD`
- `stack run list before YYYY-MM-DD`

Combining both allows milestones in a set period to be listed.

### Deleting milestones
To delete a milestone, run `delete` and specify its ID (the number given with it in the list):
```
~ : stack run delete 1
Deleted row with id 1
```

## Testing the app

To run unit tests, execute: `stack test`

Functional tests are written in python. To run them, execute: `python3 functional_tests.py`

## To-do:
- Allow db file name to be specified (allow testing without deleting the main db)
- Add date format validation

### Known Bugs:
- `after` and `before` arguments aren't case insensitive.
- Deleted return message should say `entry` not `row`.