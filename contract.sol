pragma solidity ^0.4.18;

contract course {
	string fname;
	uint age;
	address owner;
	
	function course() public {
	    owner = msg.sender;
	}
	
	modifier onlyOwner {
	    require(msg.sender == owner);
	    // if true, run the function body in place of _;
	    _;
	}

	event Instructor(
		string name,
		uint age
	);

	function setInstructor(string _fname, uint _age) onlyOwner public {
		fname = _fname;
		age = _age;
		Instructor(_fname, _age);
	}

	function getInstructor() public constant returns(string, uint) {
		return (fname, age);
	}
}