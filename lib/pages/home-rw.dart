import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ralga/api/http_request.dart';
import 'package:ralga/models/chapter_model.dart';
import 'package:ralga/pages/laws/laws-rw.dart';
import 'package:ralga/services/bookmark_service.dart';
import 'package:ralga/utils/colors.dart';

enum ChapterSort { defaultOrder, titleAZ, mostArticles }

class HomeRW extends StatefulWidget {
  final String id, title;
  const HomeRW(this.id, this.title, {Key? key}) : super(key: key);

  @override
  State<HomeRW> createState() => _HomeRWState();
}

class _HomeRWState extends State<HomeRW> {
  List<Chapters> chapters = [];
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  bool _bookmarkedOnly = false;
  ChapterSort _sort = ChapterSort.defaultOrder;
  Set<String> _bookmarks = {};

  String get _bookmarkType => 'chapters_${widget.id}';

  bool get _hasActiveFilters =>
      _bookmarkedOnly || _sort != ChapterSort.defaultOrder;

  @override
  void initState() {
    super.initState();
    _initData();
    _loadBookmarks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBookmarks() async {
    final saved = await BookmarkService.load(_bookmarkType);
    if (mounted) setState(() => _bookmarks = saved);
  }

  Future<void> _toggleBookmark(Chapters chapter) async {
    final id = chapter.id.toString();
    final added = await BookmarkService.toggle(_bookmarkType, id);
    if (!mounted) return;
    setState(() => added ? _bookmarks.add(id) : _bookmarks.remove(id));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(added ? 'Byabitswe' : 'Byakuwe mu byabitswe'),
        duration: const Duration(seconds: 1),
      ));
  }

  List<Chapters> get _visibleChapters {
    final q = _query.trim().toLowerCase();

    var list = chapters.where((c) {
      if (_bookmarkedOnly && !_bookmarks.contains(c.id.toString())) {
        return false;
      }
      if (q.isEmpty) return true;
      final title = (c.title ?? '').toLowerCase();
      final desc = (c.description ?? '').toLowerCase();
      return title.contains(q) || desc.contains(q);
    }).toList();

    switch (_sort) {
      case ChapterSort.titleAZ:
        list.sort((a, b) =>
            (a.title ?? '').toLowerCase().compareTo((b.title ?? '').toLowerCase()));
        break;
      case ChapterSort.mostArticles:
        list.sort((a, b) => (b.articleCount ?? 0).compareTo(a.articleCount ?? 0));
        break;
      case ChapterSort.defaultOrder:
        break;
    }
    return list;
  }

  Future<void> _initData({bool forceRefresh = false}) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
    });

    try {
      final response = await HttpRequest().getPublicData(
        'chapters/category/${widget.id}',
        forceRefresh: forceRefresh,
        cacheKey: 'chapters_rw_${widget.id}_v1',
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        setState(() {
          chapters = Chapters.listFromResponse(decoded);
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
          _errorMessage = 'Request failed: ${response.statusCode}';
        });
      }
    } catch (e) {
      debugPrint('Error loading data: $e');
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _isLoading = false;
        _errorMessage = 'Failed to load data. Please try again.';
      });
    }
  }

  // ───────────────────────── Filter sheet ─────────────────────────

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setSheet) {
          void update(VoidCallback fn) {
            setState(fn);
            setSheet(() {});
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Gushungura no gutondeka',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                      TextButton(
                        onPressed: () => update(() {
                          _bookmarkedOnly = false;
                          _sort = ChapterSort.defaultOrder;
                        }),
                        child: const Text('Subiza uko byari'),
                      ),
                    ],
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: appColor,
                    title: const Text('Ibyabitswe gusa'),
                    value: _bookmarkedOnly,
                    onChanged: (v) => update(() => _bookmarkedOnly = v),
                  ),
                  const SizedBox(height: 8),
                  const Text('Tondeka ukurikije',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      _sortChip('Bisanzwe', ChapterSort.defaultOrder, update),
                      _sortChip('Umutwe A–Z', ChapterSort.titleAZ, update),
                      if (widget.id != "1")
                        _sortChip(
                            'Ingingo nyinshi', ChapterSort.mostArticles, update),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColor,
                        foregroundColor: whiteColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Erekana ibisubizo'),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget _sortChip(String label, ChapterSort value,
      void Function(VoidCallback) update) {
    return ChoiceChip(
      label: Text(label),
      selected: _sort == value,
      selectedColor: appColor.withOpacity(0.15),
      onSelected: (_) => update(() => _sort = value),
    );
  }

  // ───────────────────────── UI ─────────────────────────

  PreferredSizeWidget _appBar(double height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 82),
        child: Container(
          height: height + 82,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [appColor, Color(0xFF008C8B)],
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 14, right: 8, top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 22),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded,
                              color: whiteColor, size: 19),
                          splashRadius: 20,
                        ),
                        Expanded(
                          child: Text(
                            widget.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 26),
                  child: Row(
                    children: [
                      _buildHeaderIcon(
                        Icons.refresh_rounded,
                        onPressed: () => _initData(forceRefresh: true),
                      ),
                      _buildHeaderIcon(
                        Icons.tune_rounded,
                        onPressed: _openFilterSheet,
                        showDot: _hasActiveFilters,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget _buildHeaderIcon(IconData icon,
      {VoidCallback? onPressed, bool showDot = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          IconButton(
            icon: Icon(icon, color: whiteColor, size: 20),
            onPressed: onPressed ?? () {},
            splashRadius: 20,
          ),
          if (showDot)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
      child: TextField(
        controller: _searchController,
        onChanged: (v) => setState(() => _query = v),
        textInputAction: TextInputAction.search,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: widget.id == "1" ? 'Shakisha...' : 'Shakisha imitwe...',
          hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
          prefixIcon: const Icon(Icons.search_rounded, color: Colors.black45),
          suffixIcon: _query.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.close_rounded, size: 18),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _query = '');
                  },
                ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: appColor),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off_rounded, size: 48, color: Colors.black26),
            const SizedBox(height: 12),
            Text(
              _bookmarkedOnly && _query.isEmpty
                  ? 'Nta byabitswe bihari'
                  : 'Nta bisubizo byabonetse',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            if (_hasActiveFilters || _query.isNotEmpty)
              TextButton(
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _query = '';
                    _bookmarkedOnly = false;
                    _sort = ChapterSort.defaultOrder;
                  });
                },
                child: const Text('Siba ibyashakishijwe'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: SpinKitDoubleBounce(color: appColor, size: 62),
      );
    }

    if (_hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off_rounded, size: 44, color: appColor),
              const SizedBox(height: 10),
              Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: () => _initData(forceRefresh: true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColor,
                  foregroundColor: whiteColor,
                ),
                child: const Text('Subiramo'),
              ),
            ],
          ),
        ),
      );
    }

    if (chapters.isEmpty) {
      return const Center(
        child: Text(
          'Nta bisobanuro bihari.',
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
      );
    }

    final visible = _visibleChapters;

    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          child: visible.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  color: appColor,
                  onRefresh: () => _initData(forceRefresh: true),
                  child: ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: visible.length,
                    itemBuilder: (context, position) {
                      final chapter = visible[position];
                      return GestureDetector(
                        onTap: () {
                          if (widget.id != '1') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LawsRW(
                                  chapter.id.toString(),
                                  chapter.title ?? '',
                                ),
                              ),
                            );
                          }
                        },
                        child: _buildShopItem(chapter),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      backgroundColor: const Color(0xFFF6F8F9),
      body: _buildBody(),
    );
  }

  Widget _buildShopItem(Chapters chapter) {
    final isBookmarked = _bookmarks.contains(chapter.id.toString());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6EDF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Image.asset('assets/images/rwlogo.png',
                  fit: BoxFit.contain),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chapter.title ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: appDarkColor,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                  if (widget.id != "1") ...[
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.article_outlined,
                            size: 13, color: Colors.black38),
                        const SizedBox(width: 4),
                        Text(
                          '${chapter.articleCount ?? 0} Ingingo',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (widget.id == "1" &&
                      (chapter.description ?? '').isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(
                      chapter.description ?? '',
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF718096),
                        height: 1.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              splashRadius: 20,
              tooltip: isBookmarked ? 'Kura mu byabitswe' : 'Bika',
              icon: Icon(
                isBookmarked
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
                size: 22,
                color: isBookmarked ? appColor : Colors.black38,
              ),
              onPressed: () => _toggleBookmark(chapter),
            ),
            const Icon(Icons.chevron_right_rounded,
                size: 20, color: Colors.black26),
          ],
        ),
      ),
    );
  }
}