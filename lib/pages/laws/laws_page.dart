import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ralga/api/http_request.dart';
import 'package:ralga/models/article_model.dart';
import 'package:ralga/services/saved_articles_service.dart';
import 'package:ralga/utils/colors.dart';

// ───────────────────────── Strings ─────────────────────────

class LawsStrings {
  final String noDetails;
  final String Function(int code) loadFailed;
  final String loadError;
  final String retry;
  final String empty;
  final String refresh;
  final String searchHint;
  final String noResults;
  final String noBookmarks;
  final String clearSearch;
  final String added;
  final String removed;
  final String tooltipAdd;
  final String tooltipRemove;
  final String savedOnlyTooltip;
  final String savedTitle;
  final String noSaved;

  const LawsStrings({
    required this.noDetails,
    required this.loadFailed,
    required this.loadError,
    required this.retry,
    required this.empty,
    required this.refresh,
    required this.searchHint,
    required this.noResults,
    required this.noBookmarks,
    required this.clearSearch,
    required this.added,
    required this.removed,
    required this.tooltipAdd,
    required this.tooltipRemove,
    required this.savedOnlyTooltip,
    required this.savedTitle,
    required this.noSaved,
  });

  static final en = LawsStrings(
    noDetails: 'No details available.',
    loadFailed: (c) => 'Failed to load laws ($c).',
    loadError: 'Unable to load laws. Please try again.',
    retry: 'Retry',
    empty: 'No laws available.',
    refresh: 'Refresh',
    searchHint: 'Search articles...',
    noResults: 'No results found',
    noBookmarks: 'No bookmarks in this chapter yet',
    clearSearch: 'Clear search',
    added: 'Bookmark added',
    removed: 'Bookmark removed',
    tooltipAdd: 'Bookmark',
    tooltipRemove: 'Remove bookmark',
    savedOnlyTooltip: 'Show bookmarked only',
    savedTitle: 'Saved articles',
    noSaved:
        'No saved articles yet. Tap the bookmark on any article to keep it for offline reading.',
  );

  static final fr = LawsStrings(
    noDetails: 'Aucun détail disponible.',
    loadFailed: (c) => 'Échec du chargement ($c).',
    loadError: 'Impossible de charger les lois. Réessayez.',
    retry: 'Réessayer',
    empty: 'Aucune loi disponible.',
    refresh: 'Actualiser',
    searchHint: 'Rechercher des articles...',
    noResults: 'Aucun résultat trouvé',
    noBookmarks: 'Aucun favori dans ce chapitre',
    clearSearch: 'Effacer la recherche',
    added: 'Favori ajouté',
    removed: 'Favori retiré',
    tooltipAdd: 'Ajouter aux favoris',
    tooltipRemove: 'Retirer des favoris',
    savedOnlyTooltip: 'Afficher les favoris uniquement',
    savedTitle: 'Articles enregistrés',
    noSaved:
        "Aucun article enregistré. Appuyez sur le favori d'un article pour le lire hors ligne.",
  );

  static final rw = LawsStrings(
    noDetails: 'Nta bisobanuro biboneka.',
    loadFailed: (c) => 'Byanze kugarura amategeko ($c).',
    loadError: 'Ntibishobotse kugarura amategeko. Ongera ugerageze.',
    retry: 'Ongera ugerageze',
    empty: 'Nta mategeko ahari.',
    refresh: 'Ongera usubize',
    searchHint: 'Shakisha ingingo...',
    noResults: 'Nta bisubizo byabonetse',
    noBookmarks: 'Nta ngingo zabitswe muri uyu mutwe',
    clearSearch: 'Siba ibyashakishijwe',
    added: 'Byabitswe',
    removed: 'Byakuwe mu byabitswe',
    tooltipAdd: 'Bika',
    tooltipRemove: 'Kura mu byabitswe',
    savedOnlyTooltip: 'Erekana ibyabitswe gusa',
    savedTitle: 'Ingingo zabitswe',
    noSaved:
        'Nta ngingo zabitswe. Kanda ku kimenyetso cyo kubika ku ngingo iyo ari yo yose kugira ngo uyisome nta interineti.',
  );
}

// ───────────────────────── App bar ─────────────────────────

class HeaderAction {
  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;
  final bool showDot;
  const HeaderAction({
    required this.icon,
    required this.onTap,
    this.tooltip,
    this.showDot = false,
  });
}

class LawsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<HeaderAction> actions;
  const LawsAppBar({Key? key, required this.title, this.actions = const []})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 82);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + 82,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [appDarkColor, Color(0xFF008C8B)],
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
        padding: const EdgeInsets.only(left: 14, right: 8, top: 26),
        child: Row(
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
                        title,
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
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                children: actions.map(_buildAction).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(HeaderAction a) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          IconButton(
            tooltip: a.tooltip,
            icon: Icon(a.icon, color: whiteColor, size: 20),
            onPressed: a.onTap,
            splashRadius: 20,
          ),
          if (a.showDot)
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
}

// ───────────────────────── Search bar ─────────────────────────

class LawsSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  const LawsSearchBar({
    Key? key,
    required this.controller,
    required this.hint,
    required this.onChanged,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
          prefixIcon: const Icon(Icons.search_rounded, color: Colors.black45),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.close_rounded, size: 18),
                  onPressed: onClear,
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
}

// ───────────────────────── Article card ─────────────────────────

class ArticleCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String html;
  final bool expanded;
  final bool bookmarked;
  final VoidCallback onToggle;
  final VoidCallback onBookmark;
  final String tooltipAdd;
  final String tooltipRemove;

  const ArticleCard({
    Key? key,
    required this.title,
    this.subtitle,
    required this.html,
    required this.expanded,
    required this.bookmarked,
    required this.onToggle,
    required this.onBookmark,
    required this.tooltipAdd,
    required this.tooltipRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          border: Border.all(
            color: expanded
                ? appDarkColor.withOpacity(0.3)
                : const Color(0xFFE6EDF2),
            width: expanded ? 1.5 : 1.0,
          ),
          boxShadow: expanded
              ? [
                  BoxShadow(
                      color: appDarkColor.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4))
                ]
              : [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 2))
                ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4F8),
                      borderRadius: BorderRadius.circular(8),
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
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            color: appDarkColor,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                        if (subtitle != null && subtitle!.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Text(
                            subtitle!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF718096),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    splashRadius: 20,
                    tooltip: bookmarked ? tooltipRemove : tooltipAdd,
                    icon: Icon(
                      bookmarked
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      size: 22,
                      color: bookmarked ? appColor : Colors.black38,
                    ),
                    onPressed: onBookmark,
                  ),
                  AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        color:
                            expanded ? appDarkColor : const Color(0xFFF0F4F8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: expanded ? Colors.white : appDarkColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
              ),
            ),
            if (expanded)
              const Divider(height: 1, thickness: 1, color: Color(0xFFEEF2F6)),
            AnimatedCrossFade(
              firstChild: const SizedBox(width: double.infinity),
              secondChild: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: HtmlWidget(
                    html,
                    textStyle: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF4A5568),
                      height: 1.6,
                    ),
                  ),
                ),
              ),
              crossFadeState: expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Laws page ─────────────────────────

class LawsPage extends StatefulWidget {
  final String id;
  final String title;

  /// 'en', 'fr' or 'rw'. Used for cache keys and saved articles.
  final String lang;
  final LawsStrings strings;

  const LawsPage({
    Key? key,
    required this.id,
    required this.title,
    required this.lang,
    required this.strings,
  }) : super(key: key);

  @override
  State<LawsPage> createState() => _LawsPageState();
}

class _LawsPageState extends State<LawsPage> {
  List<Article> laws = [];
  final Map<String, String> _plainText = {};
  bool _isLoading = true;
  String? _errorMessage;
  String? _expandedId;

  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  bool _savedOnly = false;
  Set<String> _savedIds = {};

  LawsStrings get s => widget.strings;

  @override
  void initState() {
    super.initState();
    _initData();
    _loadSaved();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadSaved() async {
    final items = await SavedArticlesService.load(widget.lang);
    if (mounted) setState(() => _savedIds = items.map((e) => e.id).toSet());
  }

  Future<void> _toggleSaved(Article item) async {
    final added = await SavedArticlesService.toggle(
      widget.lang,
      SavedArticle(
        id: item.id.toString(),
        title: item.title,
        law: item.law,
        chapterTitle: widget.title,
      ),
    );
    if (!mounted) return;
    setState(() {
      added
          ? _savedIds.add(item.id.toString())
          : _savedIds.remove(item.id.toString());
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(added ? s.added : s.removed),
        duration: const Duration(seconds: 1),
      ));
  }

  Future<void> _openSavedPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            SavedArticlesPage(lang: widget.lang, strings: widget.strings),
      ),
    );
    _loadSaved(); // bookmarks may have changed
  }

  // ── Data ──

  void _applyData(dynamic decoded) {
    laws = Article.listFromResponse(decoded);
    _sortArticles();
    _plainText
      ..clear()
      ..addEntries(laws.map((a) => MapEntry(a.id.toString(), _stripHtml(a.law))));
    _isLoading = false;
  }

  Future<void> _initData({bool forceRefresh = false}) async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    final String fileName =
        '${widget.id}_articleData${widget.lang.toUpperCase()}_v2.json';
    final Directory dir = await getTemporaryDirectory();
    final File file = File('${dir.path}/$fileName');

    try {
      if (!forceRefresh && file.existsSync()) {
        final decoded = json.decode(file.readAsStringSync());
        if (mounted) setState(() => _applyData(decoded));
      } else {
        final response = await HttpRequest().getPublicData(
          'articles/chapter/${widget.id}',
          forceRefresh: forceRefresh,
          cacheKey: 'laws_${widget.lang}_${widget.id}_v1',
        );

        if (response.statusCode == 200) {
          final decoded = json.decode(response.body);
          if (mounted) setState(() => _applyData(decoded));
          await file.writeAsString(response.body,
              flush: true, mode: FileMode.write);
        } else if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage = s.loadFailed(response.statusCode);
          });
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = s.loadError;
        });
      }
    }
  }

  void _sortArticles() {
    laws.sort((a, b) => _articleNumber(a).compareTo(_articleNumber(b)));
  }

  int _articleNumber(Article article) {
    final match = RegExp(
      r'\b(?:article|ingingo(?:\s+ya)?)\s*(\d+)',
      caseSensitive: false,
    ).firstMatch(article.title);
    return int.tryParse(match?.group(1) ?? '') ??
        int.tryParse(article.id.toString()) ??
        1 << 30;
  }

  static String _stripHtml(String html) => html
      .replaceAll(RegExp(r'<[^>]*>'), ' ')
      .replaceAll('&nbsp;', ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim()
      .toLowerCase();

  List<Article> get _visible {
    final q = _query.trim().toLowerCase();
    return laws.where((a) {
      final id = a.id.toString();
      if (_savedOnly && !_savedIds.contains(id)) return false;
      if (q.isEmpty) return true;
      return a.title.toLowerCase().contains(q) ||
          (_plainText[id] ?? '').contains(q);
    }).toList();
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _query = '');
  }

  // ── UI ──

  Widget _message(String text, {String? buttonLabel, VoidCallback? onPressed}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54)),
            if (buttonLabel != null) ...[
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColor,
                  foregroundColor: whiteColor,
                ),
                onPressed: onPressed,
                child: Text(buttonLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    final visible = _visible;

    return Column(
      children: [
        LawsSearchBar(
          controller: _searchController,
          hint: s.searchHint,
          onChanged: (v) => setState(() => _query = v),
          onClear: _clearSearch,
        ),
        Expanded(
          child: visible.isEmpty
              ? _message(
                  _savedOnly && _query.isEmpty ? s.noBookmarks : s.noResults,
                  buttonLabel: (_query.isNotEmpty || _savedOnly)
                      ? s.clearSearch
                      : null,
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _query = '';
                      _savedOnly = false;
                    });
                  },
                )
              : ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(8, 6, 8, 16),
                  itemCount: visible.length,
                  itemBuilder: (context, index) {
                    final item = visible[index];
                    final id = item.id.toString();
                    return ArticleCard(
                      title: item.title,
                      html: item.law.isEmpty
                          ? '<p>${s.noDetails}</p>'
                          : item.law,
                      expanded: _expandedId == id,
                      bookmarked: _savedIds.contains(id),
                      tooltipAdd: s.tooltipAdd,
                      tooltipRemove: s.tooltipRemove,
                      onToggle: () => setState(
                          () => _expandedId = _expandedId == id ? null : id),
                      onBookmark: () => _toggleSaved(item),
                    );
                  },
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_isLoading) {
      body = const Center(child: SpinKitDoubleBounce(color: appColor, size: 70));
    } else if (_errorMessage != null) {
      body = _message(_errorMessage!,
          buttonLabel: s.retry,
          onPressed: () => _initData(forceRefresh: true));
    } else if (laws.isEmpty) {
      body = _message(s.empty,
          buttonLabel: s.refresh,
          onPressed: () => _initData(forceRefresh: true));
    } else {
      body = _buildList();
    }

    return Scaffold(
      appBar: LawsAppBar(
        title: widget.title,
        actions: [
          HeaderAction(
            icon: _savedOnly
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            tooltip: s.savedOnlyTooltip,
            onTap: () => setState(() => _savedOnly = !_savedOnly),
            showDot: _savedOnly,
          ),
          HeaderAction(
            icon: Icons.collections_bookmark_outlined,
            tooltip: s.savedTitle,
            onTap: _openSavedPage,
          ),
          HeaderAction(
            icon: Icons.refresh_rounded,
            onTap: () => _initData(forceRefresh: true),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF6F8F9),
      body: body,
    );
  }
}

// ───────────────────────── Saved articles page ─────────────────────────

class SavedArticlesPage extends StatefulWidget {
  final String lang;
  final LawsStrings strings;
  const SavedArticlesPage({Key? key, required this.lang, required this.strings})
      : super(key: key);

  @override
  State<SavedArticlesPage> createState() => _SavedArticlesPageState();
}

class _SavedArticlesPageState extends State<SavedArticlesPage> {
  List<SavedArticle> _items = [];
  bool _loading = true;
  String? _expandedId;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  LawsStrings get s => widget.strings;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final items = await SavedArticlesService.load(widget.lang);
    if (!mounted) return;
    setState(() {
      _items = items;
      _loading = false;
    });
  }

  Future<void> _remove(SavedArticle item) async {
    await SavedArticlesService.remove(widget.lang, item.id);
    if (!mounted) return;
    setState(() => _items.removeWhere((e) => e.id == item.id));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(s.removed),
        duration: const Duration(seconds: 1),
      ));
  }

  List<SavedArticle> get _visible {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _items;
    return _items.where((e) {
      return e.title.toLowerCase().contains(q) ||
          e.chapterTitle.toLowerCase().contains(q) ||
          e.law.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visible;

    return Scaffold(
      appBar: LawsAppBar(title: s.savedTitle),
      backgroundColor: const Color(0xFFF6F8F9),
      body: _loading
          ? const Center(child: SpinKitDoubleBounce(color: appColor, size: 70))
          : _items.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.bookmark_border_rounded,
                            size: 48, color: Colors.black26),
                        const SizedBox(height: 12),
                        Text(s.noSaved,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    LawsSearchBar(
                      controller: _searchController,
                      hint: s.searchHint,
                      onChanged: (v) => setState(() => _query = v),
                      onClear: () {
                        _searchController.clear();
                        setState(() => _query = '');
                      },
                    ),
                    Expanded(
                      child: visible.isEmpty
                          ? Center(
                              child: Text(s.noResults,
                                  style:
                                      const TextStyle(color: Colors.black54)),
                            )
                          : ListView.builder(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              padding:
                                  const EdgeInsets.fromLTRB(8, 6, 8, 16),
                              itemCount: visible.length,
                              itemBuilder: (context, index) {
                                final item = visible[index];
                                return ArticleCard(
                                  title: item.title,
                                  subtitle: item.chapterTitle,
                                  html: item.law.isEmpty
                                      ? '<p>${s.noDetails}</p>'
                                      : item.law,
                                  expanded: _expandedId == item.id,
                                  bookmarked: true,
                                  tooltipAdd: s.tooltipAdd,
                                  tooltipRemove: s.tooltipRemove,
                                  onToggle: () => setState(() =>
                                      _expandedId = _expandedId == item.id
                                          ? null
                                          : item.id),
                                  onBookmark: () => _remove(item),
                                );
                              },
                            ),
                    ),
                  ],
                ),
    );
  }
}