#!/bin/sh
cd GoalManager
mogenerator --template-var arc=true -m GoalManager.xcdatamodeld/GoalManager.xcdatamodel/ -M Database/Machine/ -H Database/Human/
