// SPDX-License-Identifier: MIT
pragma solidity ^0.4.21;
contract Election 
{
struct Candidate
{
string name;
uint votecount;
}
struct voter 
{
bool authorized;
bool voted;
uint vote;
}
address public owner;
string public name;
mapping(address=>voter)public voters;
Candidate[]public candidates;
uint public totalvotes;
modifier ownerOnly()
{
require(msg.sender==owner);
_;
}
function election(string _name)public
{
owner=msg.sender;
name=_name;
}
function addcandiadate(string _name )ownerOnly public
{
candidates.push(Candidate(_name,0));
}

function authorize(address _person) ownerOnly public
{
voters[_person].authorized=true;
}
function vote(uint index) public
{
require(!voters[msg.sender].voted);
require(voters[msg.sender].authorized);
voters[msg.sender].vote=index;
voters[msg.sender].voted=true;
candidates[index].votecount+=1;
totalvotes+=1;
}
function end()ownerOnly public
{
selfdestruct(owner);
}
}
