import 'package:graphql/client.dart';

class ShopifyConfig {
  /// Your own unique access key found on your Shopify dashboard under apps -> manage private apps -> your-app-name .
  static String _storefrontAccessToken;

  /// Your store url.
  ///
  /// eg: "shopname.myshopify.com"
  static String _storeUrl;

  /// The version of the Storefront API.
  ///
  /// Default is set to 2020-04.
  static String _storefrontApiVersion = '2020-04';

  /// The language of the content sent by the Storefront API
  ///
  /// eg: "de"
  static String _storeLanguage;

  /// Sets the config.
  ///
  /// IMPORTANT: preferably call this inside the main function or at least before instantiating other Shopify classes.
  static void setConfig(String storefrontAccessToken, String storeUrl,
      String storefrontApiVersion,
      {String storeLanguage}) {
    _storefrontAccessToken ??= storefrontAccessToken;
    _storeUrl ??= storeUrl;
    _storefrontApiVersion = storefrontApiVersion != null
        ? storefrontApiVersion
        : _storefrontApiVersion;
    _storeLanguage ??= storeLanguage;
  }

  /// The GraphQlClient used for communication with the Storefront API.
  static final GraphQLClient graphQLClient = GraphQLClient(
    link: HttpLink(headers: {
      'X-Shopify-Storefront-Access-Token': '$_storefrontAccessToken',
      'Accept-Language': '$_storeLanguage',
    }, uri: 'https://$_storeUrl/api/$_storefrontApiVersion/graphql.json'),
    cache: NormalizedInMemoryCache(
      dataIdFromObject: typenameDataIdFromObject,
    ),
  );
}
