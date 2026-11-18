@rent-a-gig
Feature: Rent-a-Gig Platform Functionality

    Background:
        Given the Rent-a-Gig platform is running
        And the database contains test entities

    @P1 @band @event
    Scenario: Band publishes a new Event
        Given a Band with id 1 exists and has a complete profile
        When the Band submits Event details with name "Summer Festival", location "Kyiv", date "2027-07-15" and capacity 20
        Then the Event should be created with status "published"
        And the Event should have band_id 1 and capacity 20

    @P1 @band @event
    Scenario: Band tries to publish Event with incomplete profile
        Given a Band with id 1 exists and has an incomplete profile
        When the Band submits valid Event details
        Then the system should reject publication with a profile validation error

    @P1 @musician @signup
    Scenario: Musician signs up for an Event
        Given a Musician with id 1 exists
        And a published Event with id 1 exists
        When Musician 1 signs up for Event 1 with info "Available"
        Then a Signup should be created linking Musician 1 to Event 1
        And the Band that owns Event 1 should be notified by email
        And a Notification with channel "site" should be recorded for the Signup

    @P1 @musician @signup
    Scenario: Musician tries to sign up twice for same Event
        Given a Musician with id 1 exists
        And a published Event with id 1 exists
        And a Signup already exists for Musician 1 and Event 1
        When Musician 1 attempts to sign up for Event 1 again
        Then the system should reject with error "Already signed up for this event"

    @P1 @musician @signup @capacity
    Scenario: Musician signup is rejected when Event is full
        Given a published Event with id 1 exists with capacity 5
        And 5 Signups already exist for Event 1
        When a Musician attempts to sign up for Event 1
        Then the system should reject with error "Event full"

    @P2 @band @release
    Scenario: Band creates a Release
        Given a Band with id 1 exists
        And a Genre with id 1 exists
        When the Band submits Release details with name "First Album", link "https://example.com/album" and date "2027-01-01"
        Then the Release should be created
        And the Release should be linked to Band 1 and Genre 1

    @P2 @band @release
    Scenario: Band tries to create Release with invalid URL
        Given a Band with id 1 exists
        And a Genre with id 1 exists
        When the Band submits Release details with link "not-a-url"
        Then the system should reject with error "Invalid URL format"

    @P2 @musician @genre
    Scenario: Musician browses Bands by Genre
        Given a Genre with id 1 named "Rock" exists
        And Band 1 has Genre "Rock"
        And Band 2 has Genre "Jazz"
        When Musician filters Bands by Genre "Rock"
        Then the system should return only Band 1

    @P2 @musician @genre
    Scenario: Musician browses Bands by non-existent Genre
        Given Genre "Classical" has no matching Bands
        When Musician filters Bands by Genre "Classical"
        Then the system should return an empty list
        And display message "No bands found for this genre"

    @P3 @band @instrument
    Scenario: Band manages Instruments
        Given a Band with id 1 exists
        And Instrument 1 "Guitar" and Instrument 2 "Drums" exist
        When the Band adds Instruments 1 and 2
        Then the Band should be associated with Guitar and Drums

    @P3 @musician @instrument
    Scenario: Musician manages Instruments
        Given a Musician with id 1 exists
        And Instrument 1 "Guitar" exists
        When the Musician adds Instrument 1
        Then the Musician should be associated with Guitar

    @edge-case @concurrency
    Scenario: Concurrent Event signups at capacity
        Given a published Event with id 1 exists with capacity 5
        And 4 Signups already exist for Event 1
        When 2 Musicians simultaneously attempt to sign up for Event 1
        Then exactly one signup should succeed
        And the other should be rejected with "Event full" error

    @edge-case @deletion
    Scenario: Band deletes Event with Signups
        Given a Band with id 1 owns Event 1
        And multiple Signups exist for Event 1
        When Band 1 cancels Event 1
        Then the system should notify every affected Musician by email and on the site
        And the system should delete the related Signups
        And the system should delete Event 1

    @P1 @band @event
    Scenario: Band tries to publish Event with invalid date
        Given a Band with id 1 exists and has a complete profile
        When the Band submits Event details with date "2020-01-01"
        Then the system should reject with error "Event date must be in the future"

    @edge-case @referential-integrity
    Scenario: Genre deletion prevented by existing Release
        Given a Genre with id 1 exists
        And a Release with genre_id 1 exists
        When an admin attempts to delete Genre 1
        Then the system should reject with error "Genre referenced by existing releases"
