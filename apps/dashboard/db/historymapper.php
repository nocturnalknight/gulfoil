<?php

/**
 * ownCloud - Dashboard
 *
 * @author Patrick Paysant <ppaysant@linagora.com>
 * @copyright 2014 CNRS DSI
 * @license This file is licensed under the Affero General Public License version 3 or later. See the COPYING file.
 */

namespace OCA\Dashboard\Db;

use \OCP\IDb;
use \OCP\AppFramework\Db\Mapper;

class HistoryMapper extends Mapper {
    public function __construct(IDb $db) {
        parent::__construct($db, 'dashboard_history');
    }

    public function findAll($limit=null, $offset=null) {
        $sql = "SELECT * FROM *PREFIX*dashboard_history";
        return $this->findEntities($sql, $limit, $offset);
    }

    public function countFrom($datetime) {
        $sql = "SELECT id FROM *PREFIX*dashboard_history WHERE date > ? ORDER BY date";
        return $this->findEntities($sql, array(
            $datetime->format('Y-m-d H:i:s'),
        ));
    }

    public function findAllFrom($datetime) {
        $sql = "SELECT * FROM *PREFIX*dashboard_history WHERE date > ? ORDER BY date";
        return $this->findEntities($sql, array(
            $datetime->format('Y-m-d H:i:s'),
        ));
    }
}