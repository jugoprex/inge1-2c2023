import os
import csv

def print_customer(row):
    print("customer := (session select: [:c | c identificationType = '{}' and: [c identificationNumber = '{}']] ofType: Customer) asOrderedCollection at: 1.".format(row[3], row[4]))
    print("self assertCustomer: customer named: '{}' surnamed: '{}' hasIdType: '{}' numbered: '{}'.".format(row[1],row[2],row[3],row[4]))

def print_address(row):
    print("address := (session select: [:c | c streetName = '{}' and: [c streetNumber = {}]] ofType: Address) asOrderedCollection at: 1.".format(row[1], row[2]))
    print("self assertAddress: address named: '{}' numbered: {} locatedIn: '{}' zipCode: {} provinceOf: '{}' addressOf: customer.".format(row[1],row[2],row[3],row[4],row[5]))

with open('otro.txt') as f:
    c = csv.reader(f)
    for row in c:
            if row[0] == 'C': print_customer(row)
            if row[0] == 'A': print_address(row)