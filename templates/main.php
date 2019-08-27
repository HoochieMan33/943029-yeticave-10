<section class="promo">
        <h2 class="promo__title">Нужен стафф для катки?</h2>
        <p class="promo__text">На нашем интернет-аукционе ты найдёшь самое эксклюзивное сноубордическое и горнолыжное снаряжение.</p>
        <ul class="promo__list">
            <!--заполните этот список из массива категорий-->
            <?php foreach ($lot_categories as $value) { ?>
                <li class="promo__item promo__item--<?php print(strip_tags($value['code'])); ?>">
                    <a class="promo__link" href="pages/all-lots.html"><?php print(strip_tags($value['name'])) ?></a>
                </li>
            <?php } ?>
        </ul>
    </section>
    <section class="lots">
        <div class="lots__header">
            <h2>Открытые лоты</h2>
        </div>
        <ul class="lots__list">
            <!--заполните этот список из массива с товарами-->
            <?php foreach ($lots as $value) { ?>
                <li class="lots__item lot">
                    <div class="lot__image">
                        <img src=<?php print(strip_tags($value['image_url'])) ?> width="350" height="260" alt="">
                    </div>
                    <div class="lot__info">
                        <span class="lot__category"><?php print(strip_tags($lot_categories[$value['category_id']]['name'])) ?></span>
                        <h3 class="lot__title"><a class="text-link" href="pages/lot.html"><?php print(strip_tags($value['name'])) ?></a></h3>
                        <div class="lot__state">
                            <div class="lot__rate">
                                <span class="lot__amount">Стартовая цена</span>
                                <span class="lot__cost"><?php print(strip_tags(price_opt($value['price_start']))) ?></span>
                            </div>
                            <div class="lot__timer timer<?php if (get_dt_range($value['date_create'])[0] == '00') print(' timer--finishing'); ?>">
                                <?php print(get_dt_range($value['date_create'])[0].':'.get_dt_range($value['exp_date'])[1]) ?>
                            </div>
                        </div>
                    </div>
                </li>
            <?php } ?>
        </ul>
    </section>