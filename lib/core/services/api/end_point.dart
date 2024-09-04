class EndPoint {
  static const String baseUrl =
      'https://www.stc-misr-pro.com/adminapi/index.php/';

  //! Auth
  static const String login = 'login';
  //! Subscribers
  static const String allSubscribers = 'subscribers/all';
  static const String hotspotsSubscribers = 'subscribers/hotspot';
  static const String broadbandSubscribers = 'subscribers/broadband';
  static const String userGroups = 'subscribers/user_groups';
  static const String serverGroups = 'subscribers/server_groups';
  static const String addSubscriber = 'subscribers/add';
  static const String deleteSubscriber = 'subscribers/delete';
  static const String subscribersAddBalance = 'subscribers/add_balance';
  static const String subscribersResetBalance = 'subscribers/reset_balance';
  static const String subscribersRenewSubscribtion = 'subscribers/renew_subscription';
  //! offers
  static const String allOffers = 'offers/all';
  static const String addOffer = 'offers/add';
  //! vouchers
  static const String seriesVouchers = 'vouchers/series';
  static const String allVoucher = 'vouchers/all';
  static const String addVoucher = 'vouchers/add';
  //! network
  static const String networkUsersStatus = 'network/usersStatus';
  static const String networkUsaing = 'network/networkUsaing';
  static const String customerFinancialStatus =
      'network/customerFinancialStatus';
}
