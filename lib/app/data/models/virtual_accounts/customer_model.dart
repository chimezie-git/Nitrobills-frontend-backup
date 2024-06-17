// "{status: true, message: Customer created, data: {transactions: [], subscriptions: [], authorizations: [], email: anthonyaniobi198@gmail.com, first_name: Anthony, last_name: Aniobi, phone: +2349092202826, integration: 613599, domain: test, metadata: {}, customer_code: CUS_x4faw0m6fq7dd0u, risk_action: default, id: 170738023, createdAt: 2024-06-07T10:31:58.051Z, updatedAt: 2024-06-07T10:31:58.051Z, identified: false, identifications: null}}"

import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  // KEYS:
  static const String _transactionsKey = "transactions";
  static const String _subscriptionsKey = "subscriptions";
  static const String _authorizationsKey = "authorizations";
  static const String _emailKey = "email";
  static const String _firstNameKey = "first_name";
  static const String _lastNameKey = "last_name";
  static const String _phoneKey = "phone";
  static const String _integrationKey = "integration";
  static const String _domainKey = "domain";
  static const String _metadataKey = "metadata";
  static const String _customerCodeKey = "customer_code";
  static const String _riskActionKey = "risk_action";
  static const String _idKey = "id";
  static const String _createdAtKey = "createdAt";
  static const String _updatedAtKey = "updatedAt";
  static const String _identifiedKey = "identified";
  // static const String _identificationsKey = "identifications";

  // DATA:
  final List transactions;
  final List subscriptions;
  final List authorizations;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final int integration;
  final String domain;
  final Map metadata;
  final String customerCode;
  final String riskAction;
  final int id;
  final String createdAt;
  final String updatedAt;
  final bool identified;
  // final identifications;

  const CustomerModel._(
      this.transactions,
      this.subscriptions,
      this.authorizations,
      this.email,
      this.firstName,
      this.lastName,
      this.phone,
      this.integration,
      this.domain,
      this.metadata,
      this.customerCode,
      this.riskAction,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.identified);

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel._(
        json[_transactionsKey],
        json[_subscriptionsKey],
        json[_authorizationsKey],
        json[_emailKey],
        json[_firstNameKey],
        json[_lastNameKey],
        json[_phoneKey],
        json[_integrationKey],
        json[_domainKey],
        json[_metadataKey],
        json[_customerCodeKey],
        json[_riskActionKey],
        json[_idKey],
        json[_createdAtKey],
        json[_updatedAtKey],
        json[_identifiedKey],
      );

  @override
  List<Object?> get props => [
        transactions,
        subscriptions,
        authorizations,
        email,
        firstName,
        lastName,
        phone,
        integration,
        domain,
        metadata,
        customerCode,
        riskAction,
        id,
        createdAt,
        updatedAt,
        identified,
      ];
}
