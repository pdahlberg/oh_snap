
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oh_snap_client/oh_snap_client.dart';
import 'package:oh_snap_flutter/features/annotate/state/annotate_events.dart';
import 'package:oh_snap_flutter/features/annotate/state/annotate_state.dart';
import 'package:oh_snap_flutter/infra/app_router.dart';

class AnnotateBloc extends Bloc<AnnotateEvent, AnnotateState> {

  final AppRouter _appRouter;
  final Client _client;

  AnnotateBloc(
    this._appRouter,
    this._client,
  ) : super(const AnnotateState()) {
    on<FetchNfts>(_onFetchNfts);
  }

  AnnotateBloc.of(BuildContext context) : this(
    context.read(),
    context.read(),
  );

  Future<void> _onFetchNfts(FetchNfts event, Emitter<AnnotateState> emit) async {
    final nftList = await _client.annotate.fetchNfts('AMTeJt6sBoS4wXMXuCiMJkxaSGa4Ja6G7YEDnBeN4KKt');

    emit(state.copyWith(
      nfts: nftList.items,
    ));
    
  }

}
