import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../utils/http/http_client.dart';
import '../../features/shop/models/bid_model.dart';
class BidService {
  // Define API endpoints
  static const String _getAllBidsEndpoint = 'bids'; // <-- Ví dụ endpoint để lấy tất cả các bid

  Future<List<BidModel>> getBidsForAuction(String auctionSlug) async {
    try {
      final String fullEndpoint = '$_getAllBidsEndpoint/$auctionSlug'; // e.g., auctions/mac-mini-slug/bids

      final Map<String, dynamic> responseData = await THttpHelper.get(fullEndpoint);

      if (responseData['data'] is List) {
        final List<dynamic> bidListJson = responseData['data'];
        final List<BidModel> bids = bidListJson
            .map((json) => BidModel.fromJson(json as Map<String, dynamic>))
            .toList();
        print('Successfully fetched bids for auction "$auctionSlug": $bids');
        return bids;
      } else {
        throw Exception('Invalid data format received for bids of auction "$auctionSlug". Expected a List.');
      }
    } catch (e) {
      print('Error during fetching bids for auction "$auctionSlug": $e');
      rethrow;
    }
  }
}