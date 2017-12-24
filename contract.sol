pragma solidity ^0.4.18;

// Owned contract
contract Owned {
    address owner;
    
    function Owned() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}

// inherits Owned contract
contract Courses is Owned {
    struct Instructor {
        uint age;
        // strings are costly on the ethereum network, so use bytes16
        bytes16 fName;
        bytes16 lName;
    }
    
    // find an instructor based on the ethereum address of the instructor
    mapping (address => Instructor) instructors;
    
    // store addresses as an array which we can get to create functions to pass and get information
    address[] public instructorAccts;
    
    event instructorInfo(
        bytes16 fName,
        bytes16 lName,
        uint age
    );
    
    // populates instructorAccts array with instructors
    function setInstructor(address _address, uint _age, bytes16 _fName, bytes16 _lName) onlyOwner public {
        // creating a new instructor with the key of _address
        var instructor = instructors[_address];
        // set instructor age
        instructor.age = _age;
        // set instructor first name
        instructor.fName = _fName;
        // set instructor last name 
        instructor.lName = _lName;
        // reference instructorAccts
        instructorAccts.push(_address) -1;
        // use our instructorInfo event
        instructorInfo(_fName, _lName, _age);
    }
    
    // get all instructors in array
    function getInstructors() view public returns(address[]) {
        return instructorAccts;
    }
    
    // get a single instructor specified by the setInstructor function
    function getInstructor(address _address) view public returns (uint, bytes16, bytes16) {
        return (instructors[_address].age, instructors[_address].fName, instructors[_address].lName);
    }
    
    // get the total number of instructors
    function countInstructors() view public returns (uint) {
        return instructorAccts.length;
    }
}